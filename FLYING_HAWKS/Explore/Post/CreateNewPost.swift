//
//  CreateNewPost.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 28/07/23.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage

struct CreateNewPost: View {
    /// Call back
    var onPost: (Post)->()
    /// Post Properties
    @State private var postText: String = ""
    @State private var postImageData: Data?
    
    ///  Store the userData from userDefaults(AppStorage)
    @AppStorage("user_profile_url") private var profileURL: URL?
    @AppStorage("user_name") private var userName: String = ""
    @AppStorage("user_UID")private var userUID: String = ""
    
    /// View Properties
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var shwoError: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @FocusState private var showKeyboard: Bool
    
    var body: some View {
        VStack {
            HStack {
                Menu {
                    Button("Cancel",role: .destructive) {
                        dismiss()
                    }
                } label: {
                    Text("Cancel")
                        .font(.callout)
                        .foregroundColor(.white)
                }
                .hAlign(.leading)
                
                Button {
                    createPost()
                } label: {
                    Text("Post")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.horizontal,20)
                        .padding(.vertical,6)
                        .background(Color("Color2"),in: Capsule())
                    
                }
                .disableWithOpacity(postText == "")
            }
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background {
                Rectangle()
                    .fill(Color("Color").opacity(0.15))
                    .ignoresSafeArea()
            }
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    TextField("Write some thing about your's post", text: $postText, axis: .vertical)
                        .focused($showKeyboard)
                    
                    if let postImageData, let image = UIImage(data: postImageData) {
                        GeometryReader {
                            let size = $0.size
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .overlay(alignment: .topTrailing) {
                                    Button {
                                        withAnimation(.easeOut(duration: 0.25)){
                                            self.postImageData = nil
                                        }
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .fontWeight(.bold)
                                            .tint(.red)
                                        
                                    }
                                    .padding(10)
                                }
                        }
                        .clipped()
                        .frame(height: 220)
                    }
                }
                .padding(15)
            }
            Divider()
            
            HStack {
                Button {
                    showImagePicker.toggle()
                } label: {
                    Image(systemName: "photo.on.rectangle")
                        .font(.title3)
                }
                .hAlign(.leading)
                
                Button {
                    showKeyboard = false
                } label: {
                    Text("Done")
                        .font(.title3)
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal,15)
            .padding(.vertical,10)
        }
        .vAlign(.top)
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            if let newValue {
                Task {
                    if let rawImageData = try? await newValue.loadTransferable(type: Data.self), let image = UIImage(data: rawImageData), let compressedImageData = image.jpegData(compressionQuality: 0.5) {
                        ///UI must be done on main Thread.
                        await MainActor.run(body: {
                            postImageData = compressedImageData
                            photoItem = nil
                        })
                    }
                }
            }
        }
        .alert(errorMessage, isPresented: $shwoError, actions: {})
        .overlay {
            LoadingView(show: $isLoading)
        }
    }
    
    func createPost() {
        isLoading = true
        showKeyboard = false
        
        print(userName+userUID)
        Task {
           
            do {
                
                profileURL = URL(string: "\(userUID)")
                
                guard let profileURL = profileURL else {
                    

                    print("before returning --- profile url")
                    return

                }
                
               
                /// Upload the image
                let imageReferenceID = "\(userUID)\(Date())"
                let strorageRef = Storage.storage().reference().child("Post_Images").child(imageReferenceID)
                
            
                
                if let postImageData {
                    let _ = try await strorageRef.putDataAsync(postImageData)
                    let downloadURL = try await strorageRef.downloadURL()

                    let post = Post(text: postText, imageURL: downloadURL,imageReferenceID: imageReferenceID, userName: userName, userID: userUID, userProfileURL: profileURL)
                    try await createDocumentAtFirebase(post)

                } else {
                    /// here directly post text data to firebase since there is no image presents
                    let post = Post(text: postText, userName: userName, userID: userUID, userProfileURL: profileURL)
                    try await createDocumentAtFirebase(post)
                }
            } catch {
                await setError(error)
            }
        }
    }
    
    func createDocumentAtFirebase(_ post: Post) async throws {
        let _ = try Firestore.firestore().collection("Posts").addDocument(from: post, completion: { error in
            if error == nil {
                /// our post was stored in the firebse
                isLoading = false
                onPost(post)
                dismiss()
            }
        })
    }
    
    func delectAccount() {
        Task {
            do {
                guard let userUID = Auth.auth().currentUser?.uid else { return }
                //            try await Auth.auth().currentUser?.delete()
                /// Deleceting firestore user documents
                try await Firestore.firestore().collection("user").document(userUID).delete()
                /// Delecting the Auth account
                try await Auth.auth().currentUser?.delete()
            } catch {
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            shwoError.toggle()
        })
    }
}

struct CreateNewPost_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPost {_ in
            
        }
    }
}


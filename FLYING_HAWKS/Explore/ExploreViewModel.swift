//
//  ExploreViewModel.swift
//  Flying Hawks
//
//  Created by MUNAVAR PM on 15/07/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage


struct ExploreViewModel: View {
    var post: Post
    var onUpdate: (Post) -> ()
    var onDelete: () -> ()
    @State var isReacted: Bool = true
    @State var ReactCount: Int = 12
    @State private var docListner: ListenerRegistration? /// For live updation
    @AppStorage("user_UID") var userUID: String = ""
    var body: some View {
        VStack {
            HStack {
                Image("Mentor")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60,height: 40)
                    .clipShape(Circle())
                Text(post.userName)
                    .font(.footnote)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.leading,30)
            
            if let postImageURL = post.imageURL {
                GeometryReader {
                    let size = $0.size
                    WebImage(url: postImageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .frame(height: 200)
            }
            HStack {
                PostInteraction()
            }
            .vAlign(.leading)

            HStack {
                Text(post.userName).fontWeight(.semibold) +
                Text(post.text)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.footnote)
            .padding(.leading,35)
            .padding(.top, 1)
            .textSelection(.enabled)
            
            Text(post.publishedDate.formatted(date: .numeric, time: .shortened))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .padding(.leading,35)
                .padding(.top, 1)
                .foregroundColor(.gray)
        }
        .onAppear {
            /// When the post presented on the screen than it was start live updataion
            if docListner == nil {
                guard let postID = post.id else { return }
                docListner = Firestore.firestore().collection("Posts").document(postID).addSnapshotListener({ snapshot, error in
                    if let snapshot {
                        if let updatedPost = try? snapshot.data(as: Post.self) {
                            onUpdate(updatedPost)
                        }
                    } else {
                        onDelete()
                    }
                })
                
            }
        }
    }
    
    @ViewBuilder
    func PostInteraction()-> some View {
        HStack(spacing: 6) {
            Button {
                reatedPost()
            } label: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    Image(systemName: post.reactedIDs.contains(userUID) ? "hands.clap.fill" : "hands.clap")

                }
            }
            .buttonStyle(ScaleButtonStyle())
            
            
            Text("\(post.reactedIDs.count)")
                .font(.caption)
                .foregroundColor(.gray)
            
            Button {
                dislikePost()
            } label: {
                Image(systemName: post.dislikedIDs.contains(userUID) ?"hands.clap.fill" : "hands.clap")
            }
            .padding(.leading, 25)
            
            Text("\(post.dislikedIDs.count)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .foregroundColor(.white)
        .padding(.vertical, 8)
    }
    
    func reatedPost() {
        Task {
            guard let postID = post.id else { return }
            if post.reactedIDs.contains(userUID) {
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "reactedIDs": FieldValue.arrayRemove([userUID])
                ])
            } else {
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "reactedIDs" : FieldValue.arrayUnion([userUID]),
                    "dislikedIDs" : FieldValue.arrayRemove([userUID])
                ])
            }
        }
    }
    
    func dislikePost() {
        Task {
            guard let postID = post.id else { return }
            if post.dislikedIDs.contains(userUID) {
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "dislikeIDs": FieldValue.arrayRemove([userUID])
                ])
            } else {
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "reactedIDs" : FieldValue.arrayRemove([userUID]),
                    "dislikedIDs" : FieldValue.arrayUnion([userUID])
                ])
            }
        }
    }
}

//struct ExploreViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreViewModel(post: <#Post#>, onUpdate: <#(Post) -> ()#>, onDelete: <#() -> ()#>)
//    }
//}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.scaleEffect(configuration.isPressed ? 3: 1)
    }
}

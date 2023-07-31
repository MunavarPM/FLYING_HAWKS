//
//  ReusablePostView.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 30/07/23.
//

import SwiftUI
import Firebase

struct ReusablePostView: View {
    @AppStorage("user_profile_url") private var profileURL:URL?
    @AppStorage("user_name") private var userName: String = ""
    @AppStorage("user_UID")private var userUID: String = ""
    
    
    @Binding var posts: [Post]
    @State var isFetching: Bool = true
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                if isFetching {
                    ProgressView()
                        .padding(.top,30)
                } else {
                    if posts.isEmpty {
                        Text("Not Post Founded")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .padding(.top, 30)
                    } else {
                        /// Dispaly the Post's
                        post()
                    }
                    
                }
            }
            .padding(15)
        }
        .onAppear {
            Task {
                guard posts.isEmpty else { return }
                fetchPosts()
            }
        }
        .refreshable {
            isFetching = true
            posts = []
            fetchPosts()
        }
    }
    @ViewBuilder
    func post()-> some View {
        ForEach(posts) { post in
            ExploreViewModel(post: post) { updatedPost in
                /// Updating Post in the Array
                if let index = posts.firstIndex(where: { post in
                    post.id == updatedPost.id
                }){
                    posts[index].reactedIDs = updatedPost.reactedIDs
                    posts[index].dislikedIDs = updatedPost.dislikedIDs
                }
                
            } onDelete: {
                /// Remove Post from Array
                withAnimation(.easeInOut(duration: 0.25)) {
                    posts.removeAll { post.id == $0.id }
                }
            }
            Divider()
                .padding(.horizontal, -15)
        }
    }
    
    
    func fetchPosts() {
        let db = Firestore.firestore()
        let collectionReference = db.collection("Posts")
        
        collectionReference.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found.")
                return
            }
            
            //declared a variable called posts to assign that to self.posts that is to the main global @Binding var posts: [Post] ; then we can assing posts to @Binding var posts: [Post] in the main thread.
            var posts: [Post] = []
            for document in documents {
                do {
                    if let post = try document.data(as: Post?.self) {
                        
                        posts.append(post)
                        isFetching = false
                    }
                } catch {
                    print("Error decoding document: \(error.localizedDescription)")
                }
            }
            
            DispatchQueue.main.async {
                self.posts = posts
                isFetching = false
            }
        }
    }
}

struct ReusablePostView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

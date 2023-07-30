//
//  ReusablePostView.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 30/07/23.
//

import SwiftUI
import Firebase

struct ReusablePostView: View {
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
        }
        .refreshable {
            isFetching = true
            posts = []
            await fetchPost()
        }
        .task {
            /// Fetching for one time
            guard posts.isEmpty else { return }
            await fetchPost()
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
                    posts.removeAll { post == $0 }
                }
            }

        }
    }
    
    func fetchPost() async {
        do {
            var query: Query!
            query = Firestore.firestore().collection("Posts")
                .order(by: "PublishedDate", descending: true)
                .limit(to: 20)
            let docs = try await query.getDocuments()
            let fetchedPosts = docs.documents.compactMap { doc -> Post? in
                /// Decode the data to Post
                try? doc.data(as: Post.self)
            }
            await MainActor.run(body: {
                posts = fetchedPosts
                isFetching = false
            })
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ReusablePostView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

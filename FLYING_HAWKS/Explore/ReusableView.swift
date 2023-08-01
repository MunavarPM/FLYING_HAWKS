//
//  ReusableView.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 02/08/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReusableView: View {
    @State private var fetchedPost: [Post] = []
    var user: User
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                HStack(spacing: 12) {
                    WebImage(url: user.profileURL).placeholder {
                        Image("Mentor")
                            .resizable()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(user.fullname)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(user.email)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .hAlign(.leading)
                }
                
                Text("Post's")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .hAlign(.leading)
                    .padding(.vertical, 15)
                
                ReusablePostView(basedOnUID: true, uid: user.fullname, posts: $fetchedPost)
            }
            .padding()
        }
    }
}



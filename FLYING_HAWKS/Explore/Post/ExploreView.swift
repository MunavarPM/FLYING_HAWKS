//
//  ExploreView.swift
//  Flying Hawks
//
//  Created by MUNAVAR PM on 20/06/23.
//

import SwiftUI

struct ExploreView: View {
    var gradientBackground: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(hue: 213 / 360.0, saturation: 0.62, brightness: 0.45),
                Color(hue: 203 / 360.0, saturation: 0.89, brightness: 0.71),
                Color(white: 0.96)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    @State private var recentsPosts: [Post] = []
    @State private var createNewPost: Bool = false
    var body: some View {
        NavigationStack {
            ReusablePostView(posts: $recentsPosts)
                .hAlign(.center).vAlign(.center)
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        createNewPost.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(13)
                            .background(gradientBackground,in: Circle())
                    }
                    .padding(15)
                }
                .navigationTitle("Explore")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image("logo")
                            .resizable()
                            .frame(width: 125, height: 25)
                    }
                }
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color("Color1"), for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .fullScreenCover(isPresented: $createNewPost) {
                    CreateNewPost { post in
                        /// Adding to our recentpost array
                        recentsPosts.insert(post, at: 0)
                        
                }
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
            .preferredColorScheme(.dark)
    }
}

//struct explore: View {
//
//    var feedData = [
//        feed(image: "_ (7)", name: "John"),
//        feed(image: "Gavi", name: "Gavi")
//    ]
//
//    @State private var createNewPost: Bool = false
//
//    var body: some View {
//        NavigationStack {
//            ScrollView(.vertical,showsIndicators: false) {
//
//                LazyVStack(spacing: 30) {
//                    ForEach(0...10, id: \.self) { post in
//                        ExploreViewModel()
//                    }
//                }
//                .padding(.top,40)
//            }
//            .navigationTitle("Explore")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Image("logo")
//                        .resizable()
//                        .frame(width: 125, height: 25)
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        createNewPost.toggle()
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//            .toolbarBackground(.visible, for: .navigationBar)
//            .toolbarBackground(Color("Color1"), for: .navigationBar)
//            .toolbarColorScheme(.dark, for: .navigationBar)
//            .fullScreenCover(isPresented: $createNewPost) {
//                CreateNewPost { _ in
//
//                }
//            }
//        }
//    }
//}
// For feed pic's
struct feed : Identifiable {
    let id = UUID()
    let image: String
    let name: String
    
}

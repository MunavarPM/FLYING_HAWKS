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
            gradient: Gradient(stops: [
                .init(color: Color(hue: 186 / 360.0, saturation: 1.0, brightness: 0.69), location: 0.21),
                .init(color: Color(hue: 203 / 360.0, saturation: 0.89, brightness: 0.71), location: 1),
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
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SearchView()
                        } label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .accentColor(Color("Color2"))
                                .scaleEffect(0.9)
                            
                        }
                    }
                }
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color("Color1"), for: .navigationBar)
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

struct feed : Identifiable {
    let id = UUID()
    let image: String
    let name: String
    
}

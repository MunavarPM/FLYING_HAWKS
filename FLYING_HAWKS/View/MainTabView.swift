//
//  MainTab.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 27/07/23.
//

import SwiftUI

struct SwiftTabView: View {
    var body: some View {
        TabView {
            Catagories()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(1)
            
            ExploreView()
                .tabItem {
                    Label("Explore",systemImage: "photo.stack")
                }
                .tag(0)
            
            SettingsView()
                .tabItem {
                    Label("Settings",systemImage: "gear")
                }
                .tag(2)
        }
        .accentColor(Color("Color2"))
    }
}

struct SwiftTabView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftTabView()
            .preferredColorScheme(.dark)
    }
}

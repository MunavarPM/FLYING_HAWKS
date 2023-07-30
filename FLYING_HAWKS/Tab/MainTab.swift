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
            
            ExploreView()
                .tabItem {
                    Label("Explore",systemImage: "photo.stack")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings",systemImage: "gear")
                }
        }
    }
}

struct SwiftTabView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftTabView()
            .preferredColorScheme(.dark)
    }
}

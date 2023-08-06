//
//  ContentView.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 26/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthenticationModel
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @State private var isFirstLaunch = true
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        Group {
            if !UserDefaults.standard.bool(forKey: "hasLaunchedBefore") {
                OpeningView()
                    .onAppear {
                        UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
                        hasSeenOnboarding = true
                        }
                    } else if viewModel.UserSession != nil && isLoggedIn {
                        if students.isEmpty {
                            playerDetails()
                        } else {
                            SwiftTabView()
                        }
            } else {
                LoginPage()
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
          ContentView()
            .preferredColorScheme(.dark)

    }
}

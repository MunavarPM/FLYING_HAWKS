//
//  FLYING_HAWKSApp.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 26/07/23.
//

import SwiftUI
import Firebase

@main
struct Flying_HawksApp: App {
    
    @StateObject var viewModel = AuthenticationModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .preferredColorScheme(.dark)
            
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Configure Firebase")
        return true
    }
}


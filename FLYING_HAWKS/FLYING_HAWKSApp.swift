//
//  FLYING_HAWKSApp.swift
//  FLYING_HAWKS
//
//  Created by MUNAVAR PM on 26/07/23.
//

import SwiftUI

@main
struct FLYING_HAWKSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

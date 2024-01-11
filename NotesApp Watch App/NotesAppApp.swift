//
//  NotesAppApp.swift
//  NotesApp Watch App
//
//  Created by Panchami Shenoy on 6/12/23.
//

import SwiftUI

@main
struct NotesApp_Watch_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

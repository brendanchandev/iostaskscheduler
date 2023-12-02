//
//  Task_Scheduling_AppApp.swift
//  Task Scheduling App
//
//  Created by Brendan Chan on 2023-12-02.
//

import SwiftUI

@main
struct Task_Scheduling_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

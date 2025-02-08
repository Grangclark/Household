//
//  HouseholdApp.swift
//  Household
//
//  Created by 長橋和敏 on 2025/02/08.
//

import SwiftUI

@main
struct HouseholdApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

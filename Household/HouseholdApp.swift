//
//  HouseholdApp.swift
//  Household
//
//  Created by 長橋和敏 on 2025/02/08.
//

// 3. アプリのエントリポイント（HouseholdApp.swift）

import SwiftUI

@main
struct HouseholdApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // ContentView()
            MainView() // メイン画面
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

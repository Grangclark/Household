//
//  Persistence.swift
//  Household
//
//  Created by 長橋和敏 on 2025/02/08.
//

// 1. Core Data スタック（PersistenceController.swift）

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    /*
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
     */

    // let container: NSPersistentCloudKitContainer
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        // Core Data モデルファイル名（ここでは"HouseholdAppModel"と仮定）
        // container = NSPersistentCloudKitContainer(name: "Household")
        container = NSPersistentContainer(name: "HouseholdAppModel")

        if inMemory {
            // container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        /*
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
         */
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data ストアの読み込みに失敗: \(error)")
            }
        }
        // container.viewContext.automaticallyMergesChangesFromParent = true
    }

    // プレビュー用の静的プロパティを型の中に定義する
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        // ダミーデータの作成例
        /*
        for i in 0..<10 {
            let newRecord = Record(context: viewContext)
            newRecord.id = UUID()
            newRecord.type = (i % 2 == 0) ? "Income" : "Expense"
            newRecord.amount = Double(i * 1000)
            newRecord.date = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
         */
        return controller
    }()
}


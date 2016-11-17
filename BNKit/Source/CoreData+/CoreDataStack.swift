//
//  CoreDataStack.swift
//  WorkMap
//
//  Created by luojie on 16/10/25.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataStack {
    
    private let modelName: String
    
    public init(modelName: String) {
        self.modelName = modelName
    }
    
    private var managedObjectModel: NSManagedObjectModel {
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }
    
    private var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = FileManager.default.document().appendingPathComponent("\(modelName).sqlite")
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            print("Rebuild core data Persistent Store because:", error)
            try! FileManager.default.removeItem(at: url)
            try! coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        }
        
        return coordinator
    }
    
    public lazy var context: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoordinator
        return context
    }()
    
    public func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension FileManager {
    
    public func document() -> URL {
        return urls(for: .documentDirectory, in: .userDomainMask).last!
    }
}

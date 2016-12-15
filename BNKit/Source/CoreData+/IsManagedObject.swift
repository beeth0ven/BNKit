//
//  IsManagedObject.swift
//  WorkMap
//
//  Created by luojie on 16/10/25.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import CoreData

public protocol IsManagedObject: NSObjectProtocol {
    static var coreDataStack: CoreDataStack { get }
}

extension IsManagedObject where Self: NSManagedObject {
    
    public static func get(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [Self] {
        let entityName = String(describing: self)
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return try! coreDataStack.context.fetch(request)
    }
    
    public static func insert() -> Self {
        let name = String(describing: self)
        let entityDescription = NSEntityDescription.entity(forEntityName: name, in: coreDataStack.context)!
        return self.init(entity: entityDescription, insertInto: coreDataStack.context)
    }
    
    public func delete() {
        managedObjectContext?.delete(self)
    }
}


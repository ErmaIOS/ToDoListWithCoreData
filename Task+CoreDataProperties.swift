//
//  Task+CoreDataProperties.swift
//  ToDoListWithCoreData
//
//  Created by Erma on 31/7/24.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?

}

extension Task : Identifiable {

}

//
//  ToDoListEntity+CoreDataProperties.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//
//

import Foundation
import CoreData

@objc(ToDoListEntity)
public class ToDoListEntity: NSManagedObject {

}

extension ToDoListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListEntity> {
        return NSFetchRequest<ToDoListEntity>(entityName: "ToDoListEntity")
    }

    @NSManaged public var total: Int64
    @NSManaged public var skip: Int64
    @NSManaged public var limit: Int64
    @NSManaged public var taskEntity: NSSet?

}

// MARK: Generated accessors for taskEntity
extension ToDoListEntity {

    @objc(addTaskEntityObject:)
    @NSManaged public func addToTaskEntity(_ value: TaskEntity)

    @objc(removeTaskEntityObject:)
    @NSManaged public func removeFromTaskEntity(_ value: TaskEntity)

    @objc(addTaskEntity:)
    @NSManaged public func addToTaskEntity(_ values: NSSet)

    @objc(removeTaskEntity:)
    @NSManaged public func removeFromTaskEntity(_ values: NSSet)

}

extension ToDoListEntity: Identifiable {

}

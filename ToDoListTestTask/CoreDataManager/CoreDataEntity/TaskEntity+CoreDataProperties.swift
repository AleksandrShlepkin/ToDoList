//
//  TaskEntity+CoreDataProperties.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 22.09.2024.
//
//

import Foundation
import CoreData


@objc(TaskEntity)
public class TaskEntity: NSManagedObject {

}

extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var date: Date?
    @NSManaged public var day: String?
    @NSManaged public var taskID: Int64
    @NSManaged public var title: String?
    @NSManaged public var todo: String?
    @NSManaged public var userID: Int64
    @NSManaged public var relationship: ToDoListEntity?

}

extension TaskEntity : Identifiable {

}

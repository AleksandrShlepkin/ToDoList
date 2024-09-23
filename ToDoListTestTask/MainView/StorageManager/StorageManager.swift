//
//  StorageManager.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 18.09.2024.
//

import Foundation
import CoreData

protocol StorageProtocol: AnyObject {
    func fetchAllTask() -> [TaskEntity]
    func saveTask(task: ToDo)
    func deleteTask(id: Int)
    func fetchTask(id: Int) -> TaskEntity?
    func saveContext()
}

final class StorageManager: NSObject {

   private let context = CoreDataManager.shared

    func fetchAllTask() -> [TaskEntity] {
        return context.fetchObjects(TaskEntity.self, context: CoreDataManager.shared.privateManagedObjectContext)
    }

    func fetchTask(id: Int) -> TaskEntity? {
        return context.fetchObject(TaskEntity.self,
                                   predicate: .integer(.taskID, id),
                                   context: CoreDataManager.shared.mainManagedObjectContext) ?? TaskEntity()
    }

    func saveTask(task: ToDo) {
        guard let taskToDB = NSEntityDescription.insertNewObject(forEntityName: "TaskEntity",
                                                                 into: CoreDataManager.shared.privateManagedObjectContext) as? TaskEntity else { return}
        taskToDB.taskID = Int64(task.id)
        taskToDB.todo = task.todo
        taskToDB.completed = task.completed
        taskToDB.userID = Int64(task.userID)
        taskToDB.title = task.title
        taskToDB.day = task.day
        taskToDB.date = Date.now
        context.saveData()
    }

    func deleteTask(id: Int) {
        guard let task = context.fetchObject(TaskEntity.self,
                                             predicate: .integer(.taskID, id),
                                             context: context.privateManagedObjectContext) else { return }
        context.deleteData(objects: [task])
    }

    func saveContext() {
        context.saveData()
    }
}

extension StorageManager: StorageProtocol {  }

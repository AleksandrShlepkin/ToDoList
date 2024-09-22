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
    func saveTask(id: Int, todo: String?, completed: Bool, userID: Int, title: String?, day: String?, date: Date?)
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
        return context.fetchObject(TaskEntity.self, predicate: .integer(.taskID, id), context: CoreDataManager.shared.mainManagedObjectContext) ?? TaskEntity()
    }
    

    
    func saveTask(id: Int, todo: String?, completed: Bool, userID: Int, title: String?, day: String?, date: Date?) {
        let task = NSEntityDescription.insertNewObject(forEntityName: "TaskEntity", into: CoreDataManager.shared.privateManagedObjectContext) as! TaskEntity
        task.taskID = Int64(id)
        task.todo = todo
        task.completed = completed
        task.userID = Int64(userID)
        task.title = title
        task.day = day
        task.date = Date.now
        context.saveData()
    }

    
    func deleteTask(id: Int) {
        guard let task = context.fetchObject(TaskEntity.self, predicate: .integer(.taskID, id), context: context.privateManagedObjectContext) else { return }
        context.deleteData(objects: [task])
    }
    
    func saveContext() {
        context.saveData()
    }
    
}

extension StorageManager: StorageProtocol {  }

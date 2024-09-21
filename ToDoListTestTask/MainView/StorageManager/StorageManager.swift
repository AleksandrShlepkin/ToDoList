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
    func saveTask(todo: String?, completed: Bool, userID: Int, title: String?, day: String?, date: Date?)
    func deleteTask(id: Int)
    func saveTask2(task: ToDo)
    func fetchTask(id: Int) -> TaskEntity
    func saveContext()
}

final class StorageManager: NSObject {
    
   private let context = CoreDataManager.shared
        
    func fetchAllTask() -> [TaskEntity] {
        return context.fetchObjects(TaskEntity.self, context: CoreDataManager.shared.privateManagedObjectContext)
    }
    
    func fetchTask(id: Int) -> TaskEntity {
        return context.fetchObject(TaskEntity.self, predicate: .integer(.id, id), context: CoreDataManager.shared.privateManagedObjectContext) ?? TaskEntity()
    }
    
    func saveTask(todo: String?, completed: Bool, userID: Int, title: String?, day: String?, date: Date?) {
        let task = NSEntityDescription.insertNewObject(forEntityName: "TaskEntity", into: CoreDataManager.shared.privateManagedObjectContext) as! TaskEntity
        task.id = Int64(Int.random(in: 1...999999999999))
        task.todo = todo
        task.completed = completed
        task.userID = Int64(userID)
        task.title = title
        task.day = day
        task.date = Date.now
        context.saveData()
    }
    func saveTask2(task: ToDo) {
        let task = NSEntityDescription.insertNewObject(forEntityName: "TaskEntity", into: CoreDataManager.shared.privateManagedObjectContext) as! TaskEntity
        task.id = Int64(Int.random(in: 1...999999999999))
        task.todo = task.todo
        task.completed = task.completed
        task.userID = Int64(task.userID)
        task.title = task.title
        task.day = Date().dayOfWeek()
        task.date = Date.now
        print("Task save: \(task)")
        context.saveData()
    }
    
    func deleteTask(id: Int) {
        guard let task = context.fetchObject(TaskEntity.self, predicate: .integer(.id, id), context: context.privateManagedObjectContext) else { return }
        context.deleteData(objects: [task])

    }
    
    func saveContext() {
        context.saveData()
    }
    
}

extension StorageManager: StorageProtocol {  }

//
//  CoreDataManager.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import Foundation
import CoreData

enum SearchPredicate {
    case stringSearch(PredicateType, String)
    case integer(PredicateType, Int)

    var predicateType: String {
        switch self {
        case .stringSearch(let predicateType, _):
            return predicateType.rawValue
        case .integer(let predicate, _):
            return predicate.rawValue
        }
    }
    var predicateData: String {
        switch self {
        case .stringSearch(_, let value):
            return value
        case .integer(_, let value):
            return String(value)
        }
    }
}

public enum PredicateType: String {
    case taskID
    case name
}

final class CoreDataManager: NSObject {

    static let shared = CoreDataManager()
    private override init() { }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoListTestTask")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("NewCoreDataManager ------------> Error in persisten container \(error.localizedDescription)")
            } else {
                print("Store description --------> \(storeDescription)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        return container
    }()

    private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    private(set) lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = mainManagedObjectContext
        return privateContext
    }()

    private func saveMainContext() {
        if mainManagedObjectContext.hasChanges {
            do {
                try mainManagedObjectContext.save()
            } catch {
                print("CoreDataManager --------> Can't save main context. Error: \(error)")
            }
        }
    }

    private func savePrivateContext() {
        if privateManagedObjectContext.hasChanges {
            privateManagedObjectContext.performAndWait {
                do {
                    try self.privateManagedObjectContext.save()
                } catch {
                    print("CoreDataManager --------> Can't save private context. Error: \(error.localizedDescription)")
                }
            }
        }
    }

    private func saveChanges() {
        savePrivateContext()
        saveMainContext()
    }
}

// MARK: - CRUD function for CoreData

extension CoreDataManager {

    public func fetchObjects<T: NSManagedObject> (_ entityType: T.Type, predicate: SearchPredicate? = nil, fetchLimit: Int = 1) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: entityType))
        if let predicate {
            request.predicate = NSPredicate(format: "\(predicate.predicateType) == %@", predicate.predicateData)
            request.fetchLimit = fetchLimit
        }
        do {
            let objects = try mainManagedObjectContext.fetch(request)
            return objects
        } catch {
            return []
        }
    }

    public func fetchObject<T: NSManagedObject>(_ entityType: T.Type,
                                                predicate: SearchPredicate? = nil,
                                                context: NSManagedObjectContext) -> T? {
        let request = NSFetchRequest<T>(entityName: String(describing: entityType))
        if let predicate {
            request.predicate = NSPredicate(format: "\(predicate.predicateType) == %@", predicate.predicateData)
        }
        return try? context.fetch(request).first
    }

    public func fetchObjects<T: NSManagedObject>(_ entityType: T.Type,
                                                 predicate: SearchPredicate? = nil,
                                                 context: NSManagedObjectContext) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: entityType))
        if let predicate {
            request.predicate = NSPredicate(format: "\(predicate.predicateType) == %@", predicate.predicateData)
        }
        do {
            let result = try context.fetch(request)
            return result
        } catch {

        }
        return []
    }

    public func saveData() {
        self.saveChanges()
    }

    public func updateData<T: NSManagedObject>(_ entityType: T.Type, objects: [T]) {
        privateManagedObjectContext.perform {
            for object in objects {
                if object.managedObjectContext == self.privateManagedObjectContext {
                    object.managedObjectContext?.refresh(object, mergeChanges: true)
                } else {
                    let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
                    fetchRequest.predicate = NSPredicate(format: "SELF == %@", object)
                    fetchRequest.fetchLimit = 1
                    if let fetchedObject = try? self.privateManagedObjectContext.fetch(fetchRequest).first {
                        fetchedObject.setValuesForKeys(object.dictionaryWithValues(forKeys: object.entity.attributesByName.keys.map { $0 }))
                    }
                }
            }
            self.saveChanges()
        }
    }

    func deleteData<T: NSManagedObject>(objects: [T]) {
        privateManagedObjectContext.perform {
            for object in objects {
                if object.managedObjectContext == self.privateManagedObjectContext {
                    self.privateManagedObjectContext.delete(object)
                } else {
                    if let objectInContext = self.privateManagedObjectContext.object(with: object.objectID) as? T {
                        self.privateManagedObjectContext.delete(objectInContext)
                    }
                }
            }
            self.saveChanges()
        }
    }
}

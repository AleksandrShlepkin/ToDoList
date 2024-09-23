//
//  MainViewModel.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import Foundation
import Combine

public enum FilterStatus {
    case all
    case open
    case closed
}

public enum AddTask {
    case create
    case update
}

final class MainViewModel: ObservableObject {

    private(set) var network: NetworkProtocol
    private let storage: StorageProtocol = StorageManager()
    private var fetchTask = [TaskEntity]()
    private var cancelable = Set<AnyCancellable>()
    @Published var dataPublisher: ToDoModel = ToDoModel(todos: [], total: 0, skip: 0, limit: 0)
    private var taskIdentifier: Int = 0

    lazy var viewData: Published<ToDoModel>.Publisher = { [unowned self] in
        self.$dataPublisher
    }()

    init(network: NetworkProtocol) {
        self.network = network
    }

    func fetch() {
        self.fetchTask = storage.fetchAllTask()
        if fetchTask.isEmpty {
            getDataForNetwork { [weak self] result in
                self?.dataPublisher.todos = result
                self?.setTaskIdentifier()
            }
        } else {
            getDataFromBD(arrayTask: fetchTask) { tasks in
                self.dataPublisher.todos = tasks
                self.setTaskIdentifier()
            }
        }
    }

    private func setTaskIdentifier() {
        let tasks = dataPublisher.todos
        guard tasks.count > 0,
              let lastID = tasks.max(by: {$0.id < $1.id})?.id else {return}
        self.taskIdentifier = lastID + 1
    }

    private func getDataForNetwork(complition: @escaping ([ToDo]) -> Void) {
        network.getDataWithGet(.getData, responseType: ToDoModel.self)
            .receive(on: DispatchQueue.main)
            .sink { complition in
                switch complition {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: {  result in
                var tasks: [ToDo] = []

                for item in result.todos {

                    let task = ToDo(id: item.id,
                                    todo: item.todo,
                                    completed: item.completed,
                                    userID: item.userID,
                                    title: item.title,
                                    day: Date().dayOfWeek(),
                                    date: Date.now)
                    self.storage.saveTask(task: task)
                    tasks.append(task)
                }

                complition(tasks)
            }
            .store(in: &cancelable)
    }

    private func getDataFromBD(arrayTask: [TaskEntity], complition: @escaping ([ToDo]) -> Void) {
        var array = [ToDo]()

        for item in arrayTask {
            let task = ToDo(id: Int(item.taskID),
                            todo: item.todo ?? "",
                            completed: item.completed,
                            userID: Int(item.userID),
                            title: item.title,
                            day: item.day,
                            date: item.date)
            array.append(task)
        }
        DispatchQueue.main.async {
            complition(array)
        }
    }

    func addTask(action: AddTask, task: ToDo) {
        var currentTask = task
        switch action {
        case .create:
            currentTask.id = taskIdentifier
            taskIdentifier += 1
            dataPublisher.todos.insert(currentTask, at: 0)
            storage.saveTask(task: currentTask)
        case .update:
            if let taskFromDB = storage.fetchTask(id: task.id) {
                taskFromDB.title = task.title
                taskFromDB.todo = task.todo
                taskFromDB.day = task.day
                taskFromDB.date = task.date
                taskFromDB.completed = task.completed
                storage.saveContext()
            }
        }
    }

    func deleteTask(id: Int) {
        storage.deleteTask(id: id)
    }

    func completedTask(id: Int, completed: Bool) {
        guard let task = storage.fetchTask(id: id) else { return }
        task.completed = completed
        let newArray = dataPublisher
        let array = newArray.todos.map { element in
            var elem = element
            if elem.id == id {
                elem.completed = completed
            }
            return elem
        }
        self.dataPublisher.todos = array
        storage.saveContext()
    }
}

//
//  MainViewModel.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import Foundation
import Combine

protocol MainViewModelProtocol: AnyObject {
    
    func getData(complition: @escaping (ToDoModel) -> Void)
    var dataPublisher: ToDoModel { get }
    var viewData: Published<ToDoModel>.Publisher {get set}
}

final class MainViewModel: ObservableObject {
    
    private(set) var network: NetworkProtocol
    private let storage: StorageProtocol = StorageManager()
    private var fetchTask = [TaskEntity]()
    private var cancelable = Set<AnyCancellable>()
    @Published var dataPublisher: ToDoModel = ToDoModel(todos: [], total: 0, skip: 0, limit: 0)

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
                print("Data from network")
            }
        } else {
            getDataFromBD(arrayTask: fetchTask) { [weak self] result in
                self?.dataPublisher.todos = result
                print("Data from BD")
            }
        }

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
                var tasks = result.todos
                
                for item in tasks {
//                    self.storage.saveTask(todo: item.todo, completed: item.completed, userID: item.userID, title: item.title, day: item.day, date: item.date)
                    let task = ToDo(id: item.id, todo: item.todo, completed: item.completed, userID: item.userID, title: item.title, day: Date().dayOfWeek(), date: Date.now)
                    
                    tasks.append(task)
                }
               
                complition(tasks)
            }
            .store(in: &cancelable)
        
    }
    
    private func getDataFromBD(arrayTask: [TaskEntity], complition: @escaping ([ToDo]) -> Void) {
        var array = [ToDo]()
        
        for item in arrayTask {
            let task = ToDo(id: Int(item.id), todo: item.todo ?? "", completed: item.completed, userID: Int(item.userID), title: item.title, day: item.day, date: item.date)
            array.append(task)
        }
        DispatchQueue.main.async {
            complition(array)
        }
        
    }
    
    func addTask(id: Int?, todo: String, completed: Bool, userID: Int, title: String?, day: String?, date: Date?) {
        let task = ToDo(id: id ?? 0, todo: todo , completed: completed, userID: userID, title: title, day: day, date: date)
        storage.saveTask(todo: task.todo, completed: task.completed, userID: task.userID, title: task.title, day: task.day, date: task.date)
        dataPublisher.todos.insert(task, at: 0)
    }
    
    func addTask2(task: ToDo) {
        let task = ToDo(id: task.id, todo: task.todo , completed: task.completed, userID: task.userID, title: task.title, day: task.day, date: task.date)
        storage.saveTask2(task: task)
        dataPublisher.todos.append(task)
    }
    
    func deleteTask(id: Int) {
        storage.deleteTask(id: id)
    }

}

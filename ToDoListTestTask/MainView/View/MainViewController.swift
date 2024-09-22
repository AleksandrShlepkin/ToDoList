//
//  ViewController.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit
import Combine



class MainViewController: UIViewController {
    
    var mainView: MainView
    let viewModel = MainViewModel(network: NetworkManager())
    private var cancelabel = Set<AnyCancellable>()
    var flag: Bool = false
    var status: Status = .all
    var addAction: AddTask = .create
    
    var tasks = [ToDo]() {
        didSet {
            viewCountTask()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.footerView.delegate = self
        mainView.footerView.dataSource = self
        connectSubscriber()
        viewModel.fetch(status: status)
        addGesture()
        
    }
    
    init(view: MainView) {
        self.mainView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func connectSubscriber() {
        viewModel.viewData
            .receive(on: DispatchQueue.main)
            .compactMap({$0})
            .sink { [weak self] result in
                self?.tasks = result.todos
                self?.mainView.footerView.reloadData()
            }
            .store(in: &cancelabel)
    }
}


//MARK: - CollectionView delegate and DataSource
extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FooterCollectionCell.identifier, for: indexPath) as? FooterCollectionCell else { return UICollectionViewCell() }
        cell.setupViewData(tasks[indexPath.item])
        cell.delegate = self
        cell.index = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .left
        cell.addGestureRecognizer(swipeGesture)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? FooterCollectionCell
        let tap = UITapGestureRecognizer(target: self, action: #selector(openRemakeView))
        print("Index: \(indexPath.item)")
        cell?.addGestureRecognizer(tap)
    }
    
}

extension MainViewController: DelegateCell {
    func changeFlag(index: IndexPath?, flag: Bool?) {
        guard let index = index else { return }
        guard let flag = flag else { return }
        viewModel.completedTask(id: tasks[index.item].id!, completed: flag)
    }
}

//MARK: - Func action for Task
extension MainViewController {
    
    func formatterDate(item: [ToDo], index: IndexPath) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: item[index.item].date ?? Date.now)
    }
    
    
    @objc func saveNewTask(_ gesture: UITapGestureRecognizer) {
        guard let indexPath = mainView.footerView.indexPathForItem(at: gesture.location(in: mainView.footerView)) else {
            return
        }
        remakeTask(index: indexPath)

    }
    
    private func deleteTask(index: IndexPath) {
        flag.toggle()
        viewModel.deleteTask(id: tasks[index.item].id ?? 0)
        tasks.remove(at: index.item)
        mainView.footerView.deleteItems(at: [index])
        flag.toggle()
    }
    
    
    @objc func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        guard let indexPath = mainView.footerView.indexPathForItem(at: gestureRecognizer.location(in: mainView.footerView)) else {
            return
        }
        self.deleteTask(index: indexPath)
    }
    
//    @objc func handleTapGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
//        guard let indexPath = mainView.footerView.indexPathForItem(at: gestureRecognizer.location(in: mainView.footerView)) else {
//            return
//        }
//        self.remakeTask(index: indexPath)
//    }
    
    func addGesture() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(saveNewTask))
        mainView.addTaskView.addTaskButton.addGestureRecognizer(tap)
        
        let tapClosed = UITapGestureRecognizer(target: self, action: #selector(showClosedTasks))
        mainView.middleView.closedTaskButton.addGestureRecognizer(tapClosed)
        
        let tapOpen = UITapGestureRecognizer(target: self, action: #selector(showOpenTasks))
        mainView.middleView.openedTaskButton.addGestureRecognizer(tapOpen)
        
        let tapAll = UITapGestureRecognizer(target: self, action: #selector(showAllTasks))
        mainView.middleView.allTaskButton.addGestureRecognizer(tapAll)
        
        
    }
}

//MARK: - Func for data for UI
extension MainViewController {
    
    func returnCountTask(completed: Bool = false) -> [ToDo] {
        let sortedArray = tasks.filter {$0.completed == completed }
        return sortedArray
    }
    
    func viewCountTask(){
        mainView.middleView.allTaskButton.subLabel.text = String(tasks.count)
        mainView.middleView.openedTaskButton.subLabel.text = String(returnCountTask(completed: false).count)
        mainView.middleView.closedTaskButton.subLabel.text = String(returnCountTask(completed: true).count)
        
    }
    
    @objc func showClosedTasks() {
        self.status = .closed
        viewModel.fetch(status: status)
        mainView.middleView.switchTask(status: status)
        mainView.footerView.reloadData()
    }
    @objc func showOpenTasks() {
        self.status = .open
        viewModel.fetch(status: status)
        mainView.middleView.switchTask(status: status)
        mainView.footerView.reloadData()
    }
    @objc func showAllTasks() {
        self.status = .all
        viewModel.fetch(status: status)
        mainView.middleView.switchTask(status: status)
        mainView.footerView.reloadData()
    }
    
    func remakeTask(index: IndexPath?) {
        switch addAction{
        case .create:
            guard let title = mainView.addTaskView.titleTextField.text else { return }
            guard let taskText = mainView.addTaskView.taskTextField.text else { return }
            let date = mainView.addTaskView.dateTextField.text
            let id = Int.random(in: 1...999999999)
            viewModel.addTask(action: .create, id: id , todo: taskText, completed: false, userID: 1, title: title, day: date, date: Date.now)
            mainView.closeAddTask()
        case .update:
            guard let title = mainView.addTaskView.titleTextField.text else { return }
            guard let taskText = mainView.addTaskView.taskTextField.text else { return }
            let date = mainView.addTaskView.dateTextField.text
            viewModel.addTask(action: .update, id: tasks[index!.item].id ?? 0 , todo: taskText, completed: false, userID: 1, title: title, day: date, date: Date.now)
            mainView.closeAddTask()
        }
    }
    
    @objc func openRemakeView() {
        mainView.addNewTask()
        addAction = .update
    }
}

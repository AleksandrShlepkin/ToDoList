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
    var status: FilterStatus = .all
    var addAction: AddTask = .create
    var indexpathForUpdate: IndexPath?
    var tasks = [ToDo]() {
        didSet {
            viewCountTask()
        }
    }
    var tasksForView: [ToDo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.footerView.delegate = self
        mainView.footerView.dataSource = self
        connectSubscriber()
        viewModel.fetch()
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
                guard let self else {return}
                self.tasks = result.todos
                self.filteredTasks(self.status)
                self.mainView.footerView.reloadData()
            }
            .store(in: &cancelabel)
    }
}

// MARK: - CollectionView delegate and DataSource
extension MainViewController: UICollectionViewDelegate { }

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasksForView.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FooterCollectionCell.identifier,
                                                            for: indexPath) as? FooterCollectionCell else { return UICollectionViewCell() }
        cell.setupViewData(tasksForView[indexPath.item])
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .left
        cell.addGestureRecognizer(swipeGesture)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FooterCollectionCell else { return }
        self.indexpathForUpdate = indexPath
        self.openRemakeView(data: tasks, index: indexPath, cell: cell)
    }
}

// MARK: - DelegateCell
extension MainViewController: DelegateCell {

    func changeFlag(index: IndexPath?, flag: Bool?) {
        guard let index = index else { return }
        guard let flag = flag else { return }
        let completionTask = self.tasksForView[index.row]
        if status != .all {
            self.tasksForView.remove(at: index.row)
            self.mainView.footerView.deleteItems(at: [index])
        }
        viewModel.completedTask(id: completionTask.id, completed: flag)
    }
}

// MARK: - Func action for Task
extension MainViewController {

    func formatterDate(item: [ToDo], index: IndexPath) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: item[index.item].date ?? Date.now)
    }

    @objc func saveNewTask(_ gesture: UITapGestureRecognizer) {
        var indexPath = IndexPath(row: 0, section: 0)
        if let indexpathForUpdate {
            indexPath = indexpathForUpdate
        }
        remakeTask(index: indexPath)
    }

    private func deleteTask(index: IndexPath) {
        viewModel.deleteTask(id: tasksForView[index.item].id)
        tasks.removeAll(where: {$0.id == tasksForView[index.item].id})
        tasksForView.remove(at: index.item)
        mainView.footerView.deleteItems(at: [index])
        mainView.footerView.reloadData()
    }

    @objc func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        guard let indexPath = mainView.footerView.indexPathForItem(at: gestureRecognizer.location(in: mainView.footerView)) else {
            return
        }
        self.deleteTask(index: indexPath)
    }

    func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(saveNewTask))
        mainView.addTaskView.addTaskButton.addGestureRecognizer(tap)
        let tapFilterAll = UITapGestureRecognizer(target: self, action: #selector(tapFilterTask))
        let tapFilterClosed = UITapGestureRecognizer(target: self, action: #selector(tapFilterTask))
        let tapFilterOpen = UITapGestureRecognizer(target: self, action: #selector(tapFilterTask))
        mainView.middleView.closedTaskButton.addGestureRecognizer(tapFilterAll)
        mainView.middleView.openedTaskButton.addGestureRecognizer(tapFilterClosed)
        mainView.middleView.allTaskButton.addGestureRecognizer(tapFilterOpen)
    }
}

// MARK: - Func for data for UI
extension MainViewController {

    func returnCountTask(completed: Bool = false) -> [ToDo] {
        let sortedArray = tasks.filter {$0.completed == completed }
        return sortedArray
    }

    func viewCountTask() {
        mainView.middleView.allTaskButton.subLabel.text = String(tasks.count)
        mainView.middleView.openedTaskButton.subLabel.text = String(returnCountTask(completed: false).count)
        mainView.middleView.closedTaskButton.subLabel.text = String(returnCountTask(completed: true).count)
    }

    @objc func tapFilterTask(_ sender: UIGestureRecognizer) {
        guard let view = sender.view else {return}
        switch view.tag {
        case 0:
            self.status = .all
        case 1:
            self.status = .open
        case 2:
            self.status = .closed

        default: return
        }
        self.filteredTasks(self.status)
        mainView.middleView.switchTask(status: status)
        self.mainView.footerView.reloadData()
    }
    private func filteredTasks(_ state: FilterStatus) {
        switch state {
        case .all:
            self.tasksForView = tasks
        case .open:
            self.tasksForView = tasks.filter({!$0.completed})
        case .closed:
            self.tasksForView = tasks.filter({$0.completed})
        }
    }

    func remakeTask(index: IndexPath?) {
        switch addAction {
        case .create:
            guard let title = mainView.addTaskView.subTitleTextField.text else { return }
            guard let taskText = mainView.addTaskView.taskTextField.text else { return }
            guard let date = mainView.addTaskView.dateTextField.text else { return }
            if title != "" || taskText != "" {
                let task = ToDo(id: 0,
                                todo: taskText,
                                completed: false,
                                userID: 1,
                                title: title,
                                day: date,
                                date: Date.now)
                viewModel.addTask(action: .create, task: task)
            }
            mainView.closeAddTask()
            filteredTasks(self.status)
        case .update:
            guard let indexPath = index else {return}
            guard let title = mainView.addTaskView.subTitleTextField.text else { return }
            guard let taskText = mainView.addTaskView.taskTextField.text else { return }
            let date = mainView.addTaskView.dateTextField.text
            var task = self.tasksForView[indexPath.row]
            task.todo = taskText
            task.title = title
            task.day = date
            task.date = Date.now
            viewModel.addTask(action: .update, task: task)
            mainView.closeAddTask()
            addAction = .create
            self.tasksForView[indexPath.row] = task
            self.mainView.footerView.reloadItems(at: [indexPath])
        }
    }

    private func openRemakeView(data: [ToDo], index: IndexPath, cell: FooterCollectionCell) {
        mainView.addNewTask()
        addAction = .update
        mainView.addTaskView.titleLabel.text = "Update Task"
        mainView.addTaskView.subTitleTextField.text = data[index.row].title
        mainView.addTaskView.taskTextField.text = data[index.row].todo
        mainView.addTaskView.dateTextField.text = data[index.row].day
    }
}

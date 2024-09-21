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
    
    var flag: Bool = false {
        didSet {
            updateViewConstraints()
        }
    }
    
    var tasks = [ToDo]() {
        didSet {
            mainView.footerView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.footerView.delegate = self
        mainView.footerView.dataSource = self
        connectSubscriber()
        viewModel.fetch()
        let tap = UITapGestureRecognizer(target: self, action: #selector(saveNewTask))
        mainView.addTaskView.addTaskButton.addGestureRecognizer(tap)
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
                
            }
            .store(in: &cancelabel)
    }
    func formatterDate(item: [ToDo], index: IndexPath) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: item[index.item].date ?? Date.now)
    }

    
   @objc func saveNewTask() {
           guard let title = mainView.addTaskView.titleTextField.text else { return }
           guard let taskText = mainView.addTaskView.taskTextField.text else { return }
           let date = mainView.addTaskView.dateTextField.text
           viewModel.addTask(id: 0, todo: taskText, completed: false, userID: 1, title: title, day: date, date: Date.now)
       mainView.closeAddTask()
    }

    private func deleteTask(index: IndexPath) {
        viewModel.deleteTask(id: tasks[index.item].id ?? 0)
        print("delete from bd -----> ")
        tasks.remove(at: index.item)
        print("delete from array -----> \(tasks)")
        mainView.footerView.deleteItems(at: [index])
        
        
    }
    
    @objc func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        guard let indexPath = mainView.footerView.indexPathForItem(at: gestureRecognizer.location(in: mainView.footerView)) else {
            return
        }
        self.deleteTask(index: indexPath)
    }
    
}

extension MainViewController: UICollectionViewDelegate {

}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FooterCollectionCell.identifier, for: indexPath) as? FooterCollectionCell else { return UICollectionViewCell() }
        cell.titleLabel.text = tasks[indexPath.item].title
        cell.subTitleLabel.text = tasks[indexPath.item].todo
        cell.dayLabel.text = tasks[indexPath.item].day
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .left
        cell.addGestureRecognizer(swipeGesture)
    }
    
}

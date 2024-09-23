//
//  MainView.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

final class MainView: UIView {

    private(set) lazy var footerView: FooterCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = FooterCollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()

    private lazy var headerView = HeaderView()
    private(set) lazy var middleView = MiddleView()
    private(set) lazy var addTaskView = AddTaskView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainView {

    func setupView() {
        backgroundColor = .systemGray5
        addSubview(headerView)
        addSubview(middleView)
        addSubview(footerView)
        footerView.register(FooterCollectionCell.self, forCellWithReuseIdentifier: FooterCollectionCell.identifier)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addNewTask))
        headerView.addButton.addGestureRecognizer(tapGesture)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            middleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            middleView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            middleView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),

            footerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            footerView.topAnchor.constraint(equalTo: middleView.bottomAnchor, constant: 10),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension MainView {

    @objc func addNewTask() {
        addSubview(addTaskView)
        addTaskView.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: 150).isActive = true
        addTaskView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        addTaskView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        addTaskView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -150).isActive = true
        headerView.layer.opacity = 0.1
        middleView.layer.opacity = 0.1
        footerView.layer.opacity = 0.1
        footerView.isUserInteractionEnabled = false
        backgroundColor = .systemGray3
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(closeAddTask))
        swipe.direction = .down
        addGestureRecognizer(swipe)
    }

    @objc func closeAddTask() {
        addTaskView.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: 150).isActive = false
        addTaskView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = false
        addTaskView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = false
        addTaskView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -150).isActive = false
        addTaskView.dateTextField.text = ""
        addTaskView.taskTextField.text = ""
        addTaskView.subTitleTextField.text = ""
        footerView.isUserInteractionEnabled = true
        addTaskView.removeFromSuperview()
        footerView.reloadData()
        headerView.layer.opacity = 1
        middleView.layer.opacity = 1
        footerView.layer.opacity = 1
        backgroundColor = .systemGray5
    }
}

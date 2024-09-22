//
//  MiddleView.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

final class MiddleView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private(set) lazy var allTaskButton: BaseView = {
        let button = BaseView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.mainLabel.font = UIFont.systemFont(ofSize: 15)
        button.subLabel.textColor = .black
        button.separatorView.backgroundColor = .gray
        button.mainLabel.text = "All"
        button.mainLabel.font = UIFont.systemFont(ofSize: 15)
        button.mainLabel.textColor = .systemGray
        button.backgroundLabel.backgroundColor = .systemBlue
        return button
    }()
    
    private(set) lazy var openedTaskButton: BaseView = {
        let button = BaseView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.mainLabel.font = UIFont.systemFont(ofSize: 15)
        button.subLabel.textColor = .systemGray
        button.layer.cornerRadius = 5
        button.mainLabel.text = "Open"
        button.mainLabel.layer.cornerRadius = 20
        button.mainLabel.font = UIFont.systemFont(ofSize: 15)
        button.mainLabel.textColor = .systemGray
        return button
    }()
    
    private(set) lazy var closedTaskButton: BaseView = {
        let button = BaseView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.mainLabel.font = UIFont.systemFont(ofSize: 15)
        button.subLabel.textColor = .systemGray
        button.layer.cornerRadius = 5
        button.mainLabel.text = "Closed"
        button.mainLabel.layer.cornerRadius = 20
        button.mainLabel.font = UIFont.systemFont(ofSize: 15)
        button.mainLabel.textColor = .systemGray
        return button
    }()
    
    private lazy var seporatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MiddleView {
    
    func setupView() {
        addSubview(stackView)
        stackView.addArrangedSubview(allTaskButton)
        stackView.addArrangedSubview(openedTaskButton)
        stackView.addArrangedSubview(closedTaskButton)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            allTaskButton.topAnchor.constraint(equalTo: stackView.topAnchor),
            allTaskButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            allTaskButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            openedTaskButton.leadingAnchor.constraint(equalTo: allTaskButton.trailingAnchor, constant: 15),
            openedTaskButton.topAnchor.constraint(equalTo: stackView.topAnchor),
            openedTaskButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            closedTaskButton.topAnchor.constraint(equalTo: stackView.topAnchor),
            closedTaskButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            closedTaskButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
            
        ])
    }
    
}

extension MiddleView {
    
    func switchTask(status: Status) {
        switch status {
        case .all:
            closedTaskButton.backgroundLabel.backgroundColor = .systemGray5
            allTaskButton.backgroundLabel.backgroundColor = .systemBlue
            openedTaskButton.backgroundLabel.backgroundColor = .systemGray5
            
            closedTaskButton.subLabel.textColor = .systemGray
            allTaskButton.subLabel.textColor = .black
            openedTaskButton.subLabel.textColor = .systemGray
        case .open:
            closedTaskButton.backgroundLabel.backgroundColor = .systemGray5
            allTaskButton.backgroundLabel.backgroundColor = .systemGray5
            openedTaskButton.backgroundLabel.backgroundColor = .systemBlue
            
            closedTaskButton.subLabel.textColor = .systemGray
            allTaskButton.subLabel.textColor = .systemGray
            openedTaskButton.subLabel.textColor = .black
        case .closed:
            closedTaskButton.backgroundLabel.backgroundColor = .systemBlue
            allTaskButton.backgroundLabel.backgroundColor = .systemGray5
            openedTaskButton.backgroundLabel.backgroundColor = .systemGray5
            
            closedTaskButton.subLabel.textColor = .black
            allTaskButton.subLabel.textColor = .systemGray
            openedTaskButton.subLabel.textColor = .systemGray
        }
    }
}

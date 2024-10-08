//
//  MiddleView.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

final class MiddleView: UIView {

    private lazy var stackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private(set) lazy var allTaskButton: BaseView = {
        let button = BaseView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.subLabel.font = UIFont.systemFont(ofSize: 12)
        button.subLabel.textColor = .black
        button.separatorView.backgroundColor = .gray
        button.mainLabel.text = "All"
        button.mainLabel.font = UIFont.systemFont(ofSize: 15)
        button.mainLabel.textColor = .systemGray
        button.backgroundLabel.backgroundColor = .systemBlue
        button.tag = 0
        return button
    }()

    private(set) lazy var openedTaskButton: BaseView = {
        let button = BaseView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.subLabel.font = UIFont.systemFont(ofSize: 12)
        button.subLabel.textColor = .systemGray
        button.mainLabel.text = "Open"
        button.mainLabel.layer.cornerRadius = 20
        button.mainLabel.font = UIFont.systemFont(ofSize: 15)
        button.mainLabel.textColor = .systemGray
        button.tag = 1
        return button
    }()

    private(set) lazy var closedTaskButton: BaseView = {
        let button = BaseView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.subLabel.font = UIFont.systemFont(ofSize: 12)
        button.subLabel.textColor = .systemGray
        button.mainLabel.text = "Closed"
        button.mainLabel.layer.cornerRadius = 20
        button.mainLabel.font = UIFont.systemFont(ofSize: 15)
        button.mainLabel.textColor = .systemGray
        button.tag = 2
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
        stackView.addSubview(allTaskButton)
        stackView.addSubview(openedTaskButton)
        stackView.addSubview(closedTaskButton)
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            allTaskButton.topAnchor.constraint(equalTo: stackView.topAnchor),
            allTaskButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            allTaskButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),

            openedTaskButton.leadingAnchor.constraint(equalTo: allTaskButton.trailingAnchor, constant: 5),
            openedTaskButton.centerYAnchor.constraint(equalTo: allTaskButton.centerYAnchor),

            closedTaskButton.leadingAnchor.constraint(equalTo: openedTaskButton.trailingAnchor, constant: 5),
            closedTaskButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            closedTaskButton.centerYAnchor.constraint(equalTo: openedTaskButton.centerYAnchor)
        ])
    }
}

extension MiddleView {

    func switchTask(status: FilterStatus) {
        switch status {
        case .all:
            closedTaskButton.backgroundLabel.backgroundColor = .systemGray5
            allTaskButton.backgroundLabel.backgroundColor = .systemBlue
            openedTaskButton.backgroundLabel.backgroundColor = .systemGray5
            allTaskButton.separatorView.backgroundColor = .systemGray
            openedTaskButton.separatorView.backgroundColor = .none
            closedTaskButton.separatorView.backgroundColor = .none
            closedTaskButton.subLabel.textColor = .systemGray
            allTaskButton.subLabel.textColor = .black
            openedTaskButton.subLabel.textColor = .systemGray
        case .open:
            closedTaskButton.backgroundLabel.backgroundColor = .systemGray5
            allTaskButton.backgroundLabel.backgroundColor = .systemGray5
            openedTaskButton.backgroundLabel.backgroundColor = .systemBlue
            allTaskButton.separatorView.backgroundColor = .none
            openedTaskButton.separatorView.backgroundColor = .systemGray
            closedTaskButton.separatorView.backgroundColor = .none
            closedTaskButton.subLabel.textColor = .systemGray
            allTaskButton.subLabel.textColor = .systemGray
            openedTaskButton.subLabel.textColor = .black
        case .closed:
            closedTaskButton.backgroundLabel.backgroundColor = .systemBlue
            allTaskButton.backgroundLabel.backgroundColor = .systemGray5
            openedTaskButton.backgroundLabel.backgroundColor = .systemGray5
            allTaskButton.separatorView.backgroundColor = .none
            openedTaskButton.separatorView.backgroundColor = .none
            closedTaskButton.separatorView.backgroundColor = .systemGray
            closedTaskButton.subLabel.textColor = .black
            allTaskButton.subLabel.textColor = .systemGray
            openedTaskButton.subLabel.textColor = .systemGray
        }
    }
}

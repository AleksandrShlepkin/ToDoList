//
//  FooterCollectionCell.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

protocol DelegateCell: AnyObject {
    func changeFlag(index: IndexPath?, flag: Bool?)
}

final class FooterCollectionCell: UICollectionViewCell {
    
    weak var delegate: DelegateCell?
    var completed: Bool?
    
    private lazy var taskView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "No Title"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = Date().dayOfWeek()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Time label"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var doneButton: BaseButton = {
        let button = BaseButton()
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(completedAction))
        button.addGestureRecognizer(tap)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
    }
    
    func setupViewData(_ task: ToDo) {
           titleLabel.text = task.title
           subTitleLabel.text = task.todo
           dayLabel.text = task.day
           completed = task.completed
        if completed == true {
            doneButton.backgroundColor = .systemBlue
        } else {
            doneButton.backgroundColor = .none
        }
       }
}

private extension FooterCollectionCell {
    
    func setupView() {
        layer.cornerRadius = 10
        backgroundColor = .white
        addSubview(taskView)
        taskView.addSubview(titleLabel)
        taskView.addSubview(subTitleLabel)
        addSubview(separatorView)
        addSubview(dayLabel)
        addSubview(doneButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            taskView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            taskView.leadingAnchor.constraint(equalTo: leadingAnchor),
            taskView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: taskView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: taskView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: taskView.trailingAnchor, constant: -10),
            
            subTitleLabel.topAnchor.constraint(lessThanOrEqualTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: taskView.leadingAnchor, constant: 15),
            subTitleLabel.trailingAnchor.constraint(equalTo: taskView.trailingAnchor, constant: -10),
            subTitleLabel.bottomAnchor.constraint(equalTo: taskView.bottomAnchor),
            
            doneButton.centerYAnchor.constraint(equalTo: taskView.centerYAnchor),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            doneButton.leadingAnchor.constraint(greaterThanOrEqualTo: taskView.trailingAnchor, constant: 10),
            doneButton.widthAnchor.constraint(equalToConstant: 20),
            doneButton.heightAnchor.constraint(equalTo: doneButton.widthAnchor, multiplier: 1 / 1),

            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            
            dayLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            dayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    @objc func completedAction() {
        completed?.toggle()
        delegate?.changeFlag(index: indexPath, flag: completed)
        if completed == true {
            doneButton.backgroundColor = .systemBlue
        } else {
            doneButton.backgroundColor = .none
        }
    }
}

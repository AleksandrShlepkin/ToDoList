//
//  AddTaskView.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 19.09.2024.
//

import UIKit

final class AddTaskView: UIView {
    
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create new Task"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy  var subTitleTextField: BaseTextField = {
        let text = BaseTextField()
        text.keyboardType = .default
        text.backgroundColor = .systemGray5
        text.placeholder = "Title:"
        return text
    }()
    
    private(set) lazy  var taskTextField: BaseTextField = {
        let text = BaseTextField()
        text.keyboardType = .default
        text.backgroundColor = .systemGray5
        text.placeholder = "Task:"
        return text
    }()
    
    private(set) lazy  var dateTextField: BaseTextField = {
        let text = BaseTextField()
        text.attributedPlaceholder = NSAttributedString(string: "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.cgColor])
        text.keyboardType = .default
        text.backgroundColor = .systemGray5
        text.placeholder = "Date:"
        text.inputView = datePicker
        return text
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .wheels
        picker.maximumDate = .distantFuture
        picker.addTarget(self, action: #selector(dateChange), for: UIControl.Event.valueChanged)
        return picker
    }()
    
    private(set) lazy var addTaskButton: BaseView = {
        let button = BaseView()
        button.backgroundColor = .init(red: 0, green: 0, blue: 1, alpha: 0.1)
        button.mainLabel.textColor = .systemBlue
        button.subLabel.text = "New Task"
        button.mainLabel.text = "+"
        button.mainLabel.textColor = .systemBlue
        button.layer.cornerRadius = 15
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
}

private extension AddTaskView {
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(subTitleTextField)
        addSubview(taskTextField)
        addSubview(dateTextField)
        addSubview(addTaskButton)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 20
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 35),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            subTitleTextField.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 35),
            subTitleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            subTitleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            taskTextField.topAnchor.constraint(equalTo: subTitleTextField.bottomAnchor, constant: 5),
            taskTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            taskTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            dateTextField.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 5),
            dateTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            dateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            addTaskButton.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 30),
            addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addTaskButton.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -35),
            addTaskButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
   @objc func dateChange(_ datePicker: UIDatePicker) {
       dateTextField.text = dateFormatter(date: datePicker.date)
    }
    
    func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MMM d HH:mm "
        return formatter.string(from: date)
    }
}

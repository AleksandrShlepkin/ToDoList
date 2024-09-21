//
//  AddTaskView.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 19.09.2024.
//

import UIKit

final class AddTaskView: UIView {
    
    private(set) lazy  var titleTextField: BaseTextField = {
        let text = BaseTextField()
        text.keyboardType = .default
        text.backgroundColor = .systemGray5
        text.placeholder = "Hello"
        return text
    }()
    
    private(set) lazy  var taskTextField: BaseTextField = {
        let text = BaseTextField()
        text.keyboardType = .default
        text.backgroundColor = .systemGray5
        text.placeholder = "Hello"

        return text
    }()
    
    private(set) lazy  var dateTextField: BaseTextField = {
        let text = BaseTextField()
        text.attributedPlaceholder = NSAttributedString(string: "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.cgColor])
        text.keyboardType = .default
        text.backgroundColor = .systemGray5
        text.placeholder = "Hello"

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
        button.mainLabel.text = "New Task"
        button.subLabel.text = "+"
        button.subLabel.textColor = .systemBlue
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
        addSubview(titleTextField)
        addSubview(taskTextField)
        addSubview(dateTextField)
        addSubview(addTaskButton)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 20
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 15),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            taskTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5),
            taskTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            taskTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            dateTextField.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 5),
            dateTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            dateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            addTaskButton.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 30),
            addTaskButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            addTaskButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            addTaskButton.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -15),

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

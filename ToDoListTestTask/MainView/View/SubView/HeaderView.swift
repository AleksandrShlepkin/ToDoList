//
//  HeaderView.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

final class HeaderView: UIView {
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Today's Task"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = Date().dayOfWeek()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var addButton: BaseView = {
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

private extension HeaderView {
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainLabel)
        addSubview(subLabel)
        addSubview(addButton)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            mainLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -5),
            
            subLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 5),
            
            addButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            addButton.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
}

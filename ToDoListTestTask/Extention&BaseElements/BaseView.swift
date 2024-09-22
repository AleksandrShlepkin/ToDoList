//
//  BaseButton.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit


final class BaseView: UIView {
    
    private(set) lazy var subLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var mainLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var backgroundLabel: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private(set) lazy var separatorView: UIView = {
        let view = UIView()
        
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


private extension BaseView {
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundLabel)
        addSubview(mainLabel)
        addSubview(subLabel)
        addSubview(separatorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
            subLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            subLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            subLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainLabel.trailingAnchor.constraint(equalTo: subLabel.leadingAnchor, constant: -5),
            mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            backgroundLabel.topAnchor.constraint(equalTo: topAnchor),
            backgroundLabel.trailingAnchor.constraint(equalTo: subLabel.trailingAnchor, constant: 5),
            backgroundLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundLabel.leadingAnchor.constraint(equalTo: subLabel.leadingAnchor, constant: -5),
            
            separatorView.leadingAnchor.constraint(equalTo: subLabel.trailingAnchor, constant: 15),
            separatorView.centerYAnchor.constraint(equalTo: subLabel.centerYAnchor),
            separatorView.heightAnchor.constraint(equalTo: subLabel.widthAnchor),
            separatorView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }
}

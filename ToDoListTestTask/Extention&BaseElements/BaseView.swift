//
//  BaseButton.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit


final class BaseView: UIView {
    
    private(set) lazy var mainLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var subLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(mainLabel)
        addSubview(subLabel)
        addSubview(separatorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            subLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            subLabel.trailingAnchor.constraint(equalTo: mainLabel.leadingAnchor, constant: -5),
            subLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            separatorView.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 5),
            separatorView.centerYAnchor.constraint(equalTo: mainLabel.centerYAnchor),
            separatorView.heightAnchor.constraint(equalTo: mainLabel.widthAnchor, constant: -2),
            separatorView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }
}

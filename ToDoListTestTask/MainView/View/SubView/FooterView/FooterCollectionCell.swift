//
//  FooterCollectionCell.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

final class FooterCollectionCell: UICollectionViewCell {
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var separatorView: UIView = {
        let label = UIView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var doneButton: BaseButton = {
        let button = BaseButton()
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.green.cgColor
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

private extension FooterCollectionCell {
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(separatorView)
        addSubview(dayLabel)
        addSubview(timeLabel)
        addSubview(doneButton)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: -5),

            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            subTitleLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 5),
            subTitleLabel.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -5),
            
            separatorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            separatorView.widthAnchor.constraint(equalToConstant: 2),
            
            dayLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 5),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            dayLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: 5),
            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            timeLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            timeLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 5),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
        
    }
}

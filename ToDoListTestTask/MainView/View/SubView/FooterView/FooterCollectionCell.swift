//
//  FooterCollectionCell.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

final class FooterCollectionCell: UICollectionViewCell {
    
    private(set) lazy var background: UIView = {
        let label = UIView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = Date().dayOfWeek()
        label.font = UIFont.systemFont(ofSize: 15)
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
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
//        button.layer.cornerRadius = frame.width / 2
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
        doneButton.layer.cornerRadius = frame.height / 8
    }
}

private extension FooterCollectionCell {
    
    func setupView() {
        addSubview(background)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(separatorView)
        addSubview(dayLabel)
        addSubview(timeLabel)
        addSubview(doneButton)
        translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .white
        background.layer.cornerRadius = 10

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),

            subTitleLabel.topAnchor.constraint(lessThanOrEqualTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            doneButton.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            doneButton.leadingAnchor.constraint(greaterThanOrEqualTo: subTitleLabel.trailingAnchor, constant: 20),

            separatorView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 10),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            
            dayLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            timeLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 5),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
}

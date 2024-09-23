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

    override func layoutSubviews() {
        super.layoutSubviews()
        let height = mainLabel.frame.height
        backgroundLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
        backgroundLabel.layer.cornerRadius = height / 2
    }
}

private extension BaseView {

    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundLabel)
        backgroundLabel.addSubview(subLabel)
        addSubview(mainLabel)
        addSubview(separatorView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([

            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainLabel.topAnchor.constraint(equalTo: topAnchor),
            mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            backgroundLabel.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 5),
            backgroundLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            backgroundLabel.centerYAnchor.constraint(equalTo: mainLabel.centerYAnchor),

            subLabel.topAnchor.constraint(equalTo: backgroundLabel.topAnchor, constant: 2),
            subLabel.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: 5),
            subLabel.bottomAnchor.constraint(equalTo: backgroundLabel.bottomAnchor, constant: -2),
            subLabel.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: -5),

            separatorView.leadingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: 10),
            separatorView.centerYAnchor.constraint(equalTo: backgroundLabel.centerYAnchor),
            separatorView.heightAnchor.constraint(equalTo: backgroundLabel.heightAnchor),
            separatorView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }
}

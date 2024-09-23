//
//  BaseButton.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

final class BaseButton: UIView {

    private(set) lazy var doneImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "done")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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

private extension BaseButton {

    func setupView() {
        addSubview(doneImage)
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            doneImage.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            doneImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            doneImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            doneImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1)
        ])
    }
}

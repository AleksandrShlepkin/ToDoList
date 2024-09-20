//
//  BaseTextField.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 19.09.2024.
//

import UIKit

class BaseTextField: UITextField {

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        indent(size: 20)
        textColor = .black
        layer.cornerRadius = 5
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

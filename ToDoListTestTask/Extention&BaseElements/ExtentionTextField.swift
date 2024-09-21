//
//  ExtentionTextField.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 19.09.2024.
//

import UIKit
import Combine

extension UITextField {
func indent(size: CGFloat) {
    self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
    self.leftViewMode = .always
}
}

extension UITextField {
func textPublisher() -> AnyPublisher<String, Never> {
  NotificationCenter.default
      .publisher(for: UITextField.textDidChangeNotification, object: self)
      .map { ($0.object as? UITextField)?.text  ?? "" }
      .eraseToAnyPublisher()
}

}

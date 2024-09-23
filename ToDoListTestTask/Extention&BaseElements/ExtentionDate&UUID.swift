//
//  ExtentionDate&UUID.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import Foundation

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMM d HH:mm "
        return dateFormatter.string(from: self).capitalized
    }
}

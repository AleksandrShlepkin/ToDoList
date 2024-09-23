//
//  TodoModel.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import Foundation

// MARK: - ToDoModel
struct ToDoModel: Codable {
    var todos: [ToDo]
    let total, skip, limit: Int
}

// MARK: - Todo
struct ToDo: Codable {
    var id: Int
    var todo: String
    var completed: Bool
    let userID: Int
    var title: String?
    var day: String?
    var date: Date?

    enum CodingKeys: String, CodingKey {
        case id, todo, completed, title, day, date
        case userID = "userId"
    }
}

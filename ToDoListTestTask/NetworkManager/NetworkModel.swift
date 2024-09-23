//
//  NetworkModel.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import Foundation

enum NetworkModel {
    case getData
}

extension NetworkModel: EndPointType {
    var task: HTTPTask {
        return HTTPTask.request
    }

    var baseURL: URL {
        guard let url = URL(string: "https://dummyjson.com") else { fatalError("BaseURL could not be configured.") }
        return url
    }

    var path: String {
        switch self {
        case .getData:
            return "\(apiPath)"
        }
    }

    var HTTPMethod: HTTPMethod {
        switch self {
        case .getData:
            return .get
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }

    private var apiPath: String {
        switch self {
        case .getData:
            return "/todos"
        }
    }
}

//
//  HTTPTask.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request

    case requestParameters(bodyParameters: Parameters?,
                           bodyEncoding: ParameterEncoding,
                           urlParameters: Parameters?)

    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders?)
}

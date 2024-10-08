//
//  URLParameterEncoder.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest,
                              with parameters: Parameters) throws {

        guard let url = urlRequest.url else { throw NetworkError.missingURL }

        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()

            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-from-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}

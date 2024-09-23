//
//  Router.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import Foundation
import Combine

class Router: NetworkRouterProtocol {

    private var task: URLSessionTask?

    // request GET
    func request<EndPoint>(_ route: EndPoint)
    -> AnyPublisher<Data?, NetworkResponseError> where EndPoint: EndPointType {
        return Future { promise in
            let session = URLSession.shared
            guard let url = URL(string:  "\(route.baseURL)\(route.path)") else {return}
            var request = URLRequest(url: url,
                                     timeoutInterval: 60.0)
            request.httpMethod = route.HTTPMethod.rawValue
            NetworkLogger.log(request: request)
            self.task = session.dataTask(with: request, completionHandler: { data, response, error in
                if let error {
                    promise(.failure(.failed))
                }
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    if result != .success {
                        promise(.failure(result))
                    }
                }
                promise(.success(data))
            })
            self.task?.resume()
        }.eraseToAnyPublisher()
    }
    // request on combine
    func request<T, EndPoint>(_ route: EndPoint,
                              _ data: T?)
    -> AnyPublisher<Data?, NetworkResponseError> where T: Encodable, EndPoint: EndPointType {
        return Future { promise in
            let session = URLSession.shared
            guard let url = URL(string: "\(route.baseURL)\(route.path)") else {return}
            var request = URLRequest(url: url,
                                     timeoutInterval: 60.0)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try JSONEncoder().encode(data)
            } catch {
                promise(.failure(.unableToEncode))
            }
            request.httpMethod = route.HTTPMethod.rawValue
            NetworkLogger.log(request: request)
            self.task = session.dataTask(with: request, completionHandler: { data, response, error in
                if let error {
                    promise(.failure(.failed))
                }
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    if result != .success {
                        promise(.failure(result))
                    }
                }
                promise(.success(data))
            })
            self.task?.resume()
        }
        .eraseToAnyPublisher()
    }

    func cancel() {
        self.task?.cancel()
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResponseError {
        switch response.statusCode {
        case 200...299: return .success
        case 400: return .success
        case 401...500: return .authenticationError
        case 501...599: return .badRequest
        case 600: return .failed
        default: return .failed
        }
    }

}

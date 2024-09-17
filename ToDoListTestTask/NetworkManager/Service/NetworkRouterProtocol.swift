//
//  NetworkRouterProtocol.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import Foundation
import Combine

protocol NetworkRouterProtocol: AnyObject {
    // request POST
    func request<T, EndPoint>(_ route: EndPoint, _ data: T?)
    -> AnyPublisher<Data?, NetworkResponseError> where T: Encodable, EndPoint: EndPointType
    
    // request GET
    func request<EndPoint>(_ route: EndPoint)
    -> AnyPublisher<Data?, NetworkResponseError> where EndPoint: EndPointType
    
    func cancel()
}

//
//  NetworkProtocol.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import Foundation
import Combine

protocol NetworkProtocol: AnyObject {
        
    func getDataWithGet<NResponse> (_ route: NetworkModel,
                                    responseType: NResponse.Type)
    -> AnyPublisher<NResponse, Error> where NResponse: Decodable
}

final class NetworkManager: NetworkProtocol {
    
    private let router: NetworkRouterProtocol = Router()
    
    var cancelable = Set<AnyCancellable>()
    
    // MARK: - получение модели данных с GET запросом
    func getDataWithGet<NResponse> (_ route: NetworkModel,
                                    responseType: NResponse.Type)
    -> AnyPublisher<NResponse, Error> where NResponse: Decodable {
        return Future { [weak self] promise in
            guard let self else {return}
            router.request(route)
                .compactMap({$0})
                .decode(type: NResponse.self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { result in
                    promise(.success(result))
                }
                .store(in: &cancelable)
            
        }.eraseToAnyPublisher()
    }
}

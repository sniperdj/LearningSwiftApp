//
//  NetworkManager.swift
//  LearningSwift
//
//  Created by Sniper on 2023/2/11.
//

import Foundation
import Alamofire

enum NetworkResult<T> {
    case success(T)
    case failure(Error)
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func sendRequest<T: NetworkRequestProtocol>(_ data: T, completion: @escaping (NetworkResult<Data>) -> Void) {
        AF.request(data.url, method: HTTPMethod(rawValue: data.method), parameters: data.parameters, encoding: URLEncoding.default, headers: HTTPHeaders(data.headers)).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(response.data!))
            }
        }
    }
}
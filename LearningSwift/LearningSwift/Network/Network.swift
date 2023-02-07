//
//  Network.swift
//  LearningSwift
//
//  Created by Sniper on 2023/2/7.
//

import Foundation
import Alamofire

class Network {
    static let shared = Network()
    
    private init() {}
    
    func request<T: NetworkDataProtocol>(_ data: T) {
        AF.request(data.url, method: HTTPMethod(rawValue: data.method), parameters: data.parameters, encoding: URLEncoding.default, headers: HTTPHeaders(data.headers)).response { response in
            data.completion(response.data, response.response, response.error)
        }
    }
}

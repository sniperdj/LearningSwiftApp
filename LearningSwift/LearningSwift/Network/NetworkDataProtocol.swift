//
//  NetworkDataProtocol.swift
//  LearningSwift
//
//  Created by Sniper on 2023/2/7.
//

import Foundation

protocol NetworkDataProtocol {
    var url: URL { get }
    var method: String { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    var completion: (Data?, URLResponse?, Error?) -> Void { get }
//    var encoding: URLEncoding { get }
}

extension NetworkDataProtocol {
    var method: String {
        return "GET"
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var parameters: [String: Any] {
        return [:]
    }
}

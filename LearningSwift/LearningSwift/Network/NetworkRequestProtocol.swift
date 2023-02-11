//
//  NetworkRequestProtocol.swift
//  LearningSwift
//
//  Created by Sniper on 2023/2/11.
//

import Foundation

protocol NetworkRequestProtocol {
    // 用于请求的URL
    var url: URL { get }
    // 请求方法
    var method: String { get }
    // 请求头
    var headers: [String: String] { get }
    // 请求参数
    var parameters: [String: Any] { get }

}

extension NetworkRequestProtocol {
    
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
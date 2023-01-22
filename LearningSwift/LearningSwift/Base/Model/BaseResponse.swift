//
//  BaseResponse.swift
//  LearningSwift
//
//  Created by Sniper on 2023/1/22.
//

import Foundation

protocol BaseResponseProtocol {
    associatedtype T: Codable
    var code: Int { get }
    var msg: String { get }
    var data: T { get }
}

//class BaseResponse<T: Codable>: Codable {
//    let code: Int
//    let message: String
//    let data: T
//}

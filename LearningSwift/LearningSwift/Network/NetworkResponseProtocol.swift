//
//  NetworkResponseProtocol.swift
//  LearningSwift
//
//  Created by Sniper on 2023/2/11.
//

import Foundation

protocol NetworkResponseProtocol {
    associatedtype T
    var code: Int { get }
    var msg: String { get }
    var data: T { get }
}
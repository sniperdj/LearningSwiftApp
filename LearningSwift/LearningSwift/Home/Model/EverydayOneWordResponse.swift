//
//  EverydayOneWordResponse.swift
//  LearningSwift
//
//  Created by Sniper on 2023/1/28.
//

import Foundation
import HandyJSON

struct EverydayOne: Codable, HandyJSON {
    let content: String
    let author: String
    
    init() {
        content = ""
        author = ""
    }
}

struct EverydayOneWordResponse: BaseResponseProtocol, HandyJSON {
    init() {
        code = 0
        msg = ""
        data = Array<EverydayOne>()
    }
   
    typealias T = Array
    let code: Int
    let msg: String
    let data: Array<EverydayOne>
}

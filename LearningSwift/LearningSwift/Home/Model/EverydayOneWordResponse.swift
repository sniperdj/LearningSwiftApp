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
    // 这个不是后台返回的,是我自己加的,为了更好的显示图片 
    var lunbo: String
    
    init() {
        content = ""
        author = ""
        lunbo = "lunbo0"
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

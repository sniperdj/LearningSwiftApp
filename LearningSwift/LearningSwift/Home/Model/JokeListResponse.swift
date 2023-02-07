//
//  JokeListResponse.swift
//  LearningSwift
//
//  Created by Sniper on 2023/1/22.
//

import Foundation
import HandyJSON

struct JokeItem: HandyJSON {
    let content: String?
    let updateTime: String?
    
    init() {
        content = ""
        updateTime = ""
    }

    init(content: String, updateTime: String) {
        self.content = content
        self.updateTime = updateTime
    }
}

struct JokeListData: HandyJSON {
    let page: Int
    let totalCount: Int
    let totalPage: Int
    let limit: Int
    let list: [JokeItem]

    init() {
        page = 0
        totalCount = 0
        totalPage = 0
        limit = 0
        list = []
    }
}

 struct JokeListResponse: BaseResponseProtocol, HandyJSON {
     init() {
         code = 0
         msg = ""
         data = JokeListData()
     }
    
     typealias T = JokeListData
     let code: Int
     let msg: String
     let data: JokeListData
 }

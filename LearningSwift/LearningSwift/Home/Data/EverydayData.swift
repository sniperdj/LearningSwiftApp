//
//  EverydayData.swift
//  LearningSwift
//
//  Created by Sniper on 2023/2/11.
//

import Foundation

struct EverydayData: NetworkRequestProtocol {
    var method: String
    
    // 接口地址
    var url: URL = URL(string: "https://www.mxnzp.com/api/daily_word/recommend")!
    var parameters: [String : Any] = [
            "app_id": ConstEncryptValues.everydayWordAppId,
            "app_secret": ConstEncryptValues.everydayWordAppSecret,
            "count":4]
    var headers: [String : String] = [:]
}

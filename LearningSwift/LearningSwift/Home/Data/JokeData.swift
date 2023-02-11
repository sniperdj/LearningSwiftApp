//
//  JokeData.swift
//  LearningSwift
//
//  Created by Sniper on 2023/2/11.
//

import Foundation

struct JokeData: NetworkRequestProtocol {
    var method: String
    
    // 接口地址
    var url: URL = URL(string: "https://www.mxnzp.com/api/jokes/list")!
    var parameters: [String : Any] = [
           "app_id": ConstEncryptValues.jokeAppId,
           "app_secret": ConstEncryptValues.jokeAppSecret,
           "page":0]
    var headers: [String : String] = [:]
}

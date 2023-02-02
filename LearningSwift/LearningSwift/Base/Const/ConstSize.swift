//
//  ConstSize.swift
//  LearningSwift
//
//  Created by Sniper on 2023/1/19.
//

import Foundation
import UIKit

struct ConstSize {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height

    // 适配刘海屏状态栏高度
    static let statusBarHeight : CGFloat = isiPhoneXorLater() ? 44.0 : 20.0
    // 适配iPhone X 导航栏高度
    static let naviBarHeight : CGFloat = statusBarHeight + 44

    static func isiPhoneXorLater() -> Bool {
        // TODO: 适配iPhone X以前的机型
        return true
    }

    static let tabbarHeight : CGFloat = isiPhoneXorLater() ? 49 + 34 : 49
}

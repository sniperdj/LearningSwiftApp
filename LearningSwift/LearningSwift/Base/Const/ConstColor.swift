//
//  ConstColor.swift
//  LearningSwift
//
//  Created by Sniper on 2023/1/19.
//

import Foundation
import UIKit

//MARK: 应用默认颜色
struct ConstColor {

    static let mainColor = hexColorWithAlpha(hex: "1296db", alpha: 1.0)
    static let backgroundColor = UIColor.white

    static let unselectedColor = hexColorWithAlpha(hex: "bfbfbf", alpha: 1.0)

    static func hexColorWithAlpha(hex: String, alpha: CGFloat) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString = (cString as NSString).substring(from: 1)
        }

        if cString.count != 6 {
            return UIColor.clear
        }

        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)

        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)

        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
}

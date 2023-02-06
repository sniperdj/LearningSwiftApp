//
//  DynamicLaunchImage.swift
//  LearningSwift
//
//  Created by Sniper on 2023/2/6.
//

import Foundation
import UIKit

class DynamicLaunchImage {
    static func replaceLaunchImage(replacementImage: UIImage) -> Bool {
        
        return replaceLaunchImage(replacementImage: replacementImage, compressionQuality: 0.8)
    }

    static func replaceLaunchImage(replacementImage: UIImage, compressionQuality: CGFloat) -> Bool {
        return replaceLaunchImage(replacementImage: replacementImage, compressionQuality: compressionQuality, customValidation: nil)
    }

    static func replaceLaunchImage(replacementImage: UIImage, compressionQuality: CGFloat, customValidation: ((UIImage, UIImage) -> Bool)?) -> Bool {

        // 转为jpeg
        guard let imgData = replacementImage.jpegData(compressionQuality: compressionQuality) else {
            return false
        }
        
        // 检查图片尺寸是否等同屏幕分辨率
        guard checkImageMatchScreenSize(replacementImage) else {
            return false
        }
        // 获取系统启动图缓存路径
        let cacheDirectory = launchImageCacheDirectory()
        if (cacheDirectory == nil) {
            return false
        }
        // 工作目录
        let cachesDirectory = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let workDirectory = cachesDirectory! + "/_tmpLaunchImageCaches"

        // 清理工作目录
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: workDirectory) {
            do {
                try fileManager.removeItem(atPath: workDirectory)
            } catch {
                return false
            }
        }
        // 移动系统缓存目录内容至工作目录
        do {
            try fileManager.moveItem(atPath: cacheDirectory!, toPath: workDirectory)
        } catch {
            return false
        }

        // 记录需要操作的图片名
        var cacheImageNames = [String]()
        for fileName in fileManager.enumerator(atPath: workDirectory)! {
            if isSnapshotName(fileName as! String) {
                cacheImageNames.append(fileName as! String)
            }
        }

        // 写入替换文件
        for imageName in cacheImageNames {
            let imagePath = workDirectory + "/" + imageName
            // 自定义校验
            var result = true
            if customValidation != nil {
                // 读取缓存图片
                let cacheImageData = try? Data(contentsOf: URL(fileURLWithPath: imagePath))
                if cacheImageData == nil {
                    return false
                }
                guard let cachedImage = imageFromData(cacheImageData!) else {
                    return false
                }
                result = customValidation!(cachedImage, replacementImage)
            }
            if result {
                do {
                    try imgData.write(to: URL(fileURLWithPath: imagePath))
                    print("写入成功了")
                } catch {
                    print("写入失败了")
                    return false
                }
            }
        }

        // 还原系统缓存目录
        do {
            try fileManager.moveItem(atPath: workDirectory, toPath: cacheDirectory!)
        } catch {
//            return false
            print("还原失败了")
        }

        // 清理工作目录
        if fileManager.fileExists(atPath: workDirectory) {
            do {
                try fileManager.removeItem(atPath: workDirectory)
            } catch {
                print("清理工作目录失败了")
            }
        }

        return true
    }
    // MARK: - Private
    /// 系统启动图缓存路径
    static func launchImageCacheDirectory() -> String? {
        let bandleId = Bundle.main.bundleIdentifier
        let fileManager = FileManager.default

        // before iOS 13
        let cachesDirectory = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let snapShotsPath = cachesDirectory! + "/Snapshots/" + bandleId!
        print("snapShotsPath = \(snapShotsPath)")
        
        if fileManager.fileExists(atPath: snapShotsPath) {
            return snapShotsPath
        }
        // iOS 13 or later
        let libraryDirectory = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
        let snapShotsPathAfteriOS13 = libraryDirectory! + "/SplashBoard/Snapshots/" + bandleId! + " - {DEFAULT GROUP}"
        print("snapShotsPathAfteriOS13 = \(snapShotsPathAfteriOS13)")
        if fileManager.fileExists(atPath: snapShotsPathAfteriOS13) {
            return snapShotsPathAfteriOS13
        }
        return nil
    }

    /// 系统启动图后缀名
    static func isSnapshotName(_ name: String) -> Bool {
        return name.hasSuffix(".png") || name.hasSuffix(".ktx")
    }

    static func checkImageMatchScreenSize(_ image: UIImage) -> Bool {
        let screenSize = UIScreen.main.bounds.size.applying(CGAffineTransform(scaleX: UIScreen.main.scale, y: UIScreen.main.scale))
        let imageSize = image.size.applying(CGAffineTransform(scaleX: image.scale, y: image.scale))
        if imageSize.equalTo(screenSize) {
            return true
        }
        if imageSize.width == screenSize.height && imageSize.height == screenSize.width {
            return true
        }
        return false
    }

    static func imageFromData(_ data: Data) -> UIImage? {
        
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }

        guard let imageRef = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
            return nil
        }

        let originImage = UIImage(cgImage: imageRef)
//        releaseImageSource(source)
//        releaseImage(imageRef)

        return originImage
    }
}

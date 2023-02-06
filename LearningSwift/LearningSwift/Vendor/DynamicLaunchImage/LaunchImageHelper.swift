//
//  LaunchImageHelper.swift
//  LearningSwift
//
//  Created by Sniper on 2023/2/6.
//

import Foundation
import UIKit

class LaunchImageHelper {

    static func snapshotStoryboard(sbName: String, isPortrait: Bool) -> UIImage? {
        if (sbName == nil) {
            return nil
        }
        let sb = UIStoryboard(name: sbName, bundle: nil)
//        guard sb != nil else {
//            return nil
//        }
        guard let vc = sb.instantiateInitialViewController() else {
            return nil
        }
        vc.view.frame = UIScreen.main.bounds
        if (isPortrait) {
            if (vc.view.frame.size.width > vc.view.frame.size.height) {
                // vc.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
                // vc.view.frame = UIScreen.main.bounds
                vc.view.frame = CGRect(x: 0, y: 0, width: vc.view.frame.size.height, height: vc.view.frame.size.width)
            }
        } else {
            if (vc.view.frame.size.width < vc.view.frame.size.height) {
                // vc.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
                // vc.view.frame = UIScreen.main.bounds
                vc.view.frame = CGRect(x: 0, y: 0, width: vc.view.frame.size.height, height: vc.view.frame.size.width)
            }
        }
        vc.view.setNeedsLayout()
        vc.view.layoutIfNeeded()

        UIGraphicsBeginImageContextWithOptions(vc.view.frame.size, false, UIScreen.main.scale)
        vc.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    static func snapshotStoryboardForLandscape(sbName: String) -> UIImage? {
        return snapshotStoryboard(sbName: sbName, isPortrait: false)
    }

    static func snapshotStoryboardForPortrait(sbName: String) -> UIImage? {
        return snapshotStoryboard(sbName: sbName, isPortrait: true)
    }

    static func changeAllLaunchImageToPortrait(image: UIImage) {
        if (image == nil) {
            return
        }
        let portraitImage = resizeImageToPortraitScreenSize(image: image, isPortrait: true)
        print("portraitImage size  : \(portraitImage.size)")
        let result = DynamicLaunchImage.replaceLaunchImage(replacementImage: portraitImage)
        print("result : \(result)")
    }

    static func changeAllLaunchImageToLandscape(image: UIImage) {

    }

    static func changePortraitLaunchImageAndLandscapeLaunchImage(portraitImage: UIImage, landscapeImage: UIImage) {

    }

    // MARK: - Private
    static func checkImageSizeEqualToImage(aImage: UIImage, bImage: UIImage) -> Bool {
        
        return obtainImageSize(image: aImage).equalTo(obtainImageSize(image: bImage))
    }

    static func obtainImageSize(image: UIImage) -> CGSize {
        guard image.cgImage != nil else {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: image.cgImage!.width, height: image.cgImage!.height)
    }

    static func contextSizeForPortrait(isPortrait: Bool) -> CGSize {
        let screenScale = UIScreen.main.scale
        let screenSize = UIScreen.main.bounds.size
        var width = min(screenSize.width, screenSize.height)
        var height = max(screenSize.width, screenSize.height)
        if (!isPortrait) {
            width = max(screenSize.width, screenSize.height)
            height = min(screenSize.width, screenSize.height)
        }
        return CGSize(width: width * screenScale, height: height * screenScale)
    }

    static func resizeImageToPortraitScreenSize(image: UIImage, isPortrait: Bool) -> UIImage {
        // let imageSize = __CGSizeApplyAffineTransform(image.size, CGAffineTransform(scaleX: image.scale, y: image.scale))
        let imageSize = image.size.applying(CGAffineTransform(scaleX: image.scale, y: image.scale))
        let contextSize = contextSizeForPortrait(isPortrait: isPortrait)

        if (!imageSize.equalTo(contextSize)) {
            UIGraphicsBeginImageContext(contextSize)
            // let ratio = MAX(contextSize.width / imageSize.width, contextSize.height / imageSize.height)
            let ratio = max(contextSize.width / imageSize.width, contextSize.height / imageSize.height)
            image.draw(in: CGRect(x: 0, y: 0, width: image.size.width * ratio, height: image.size.height * ratio))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            if (newImage != nil) {
                return newImage!
            }
            return image
        }
        return image
    }
}

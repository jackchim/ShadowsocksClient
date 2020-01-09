//
//  UIImage+Extension.swift
//  SSFree
//
//  Created by Ning Li on 2020/1/8.
//  Copyright © 2020 Ning Li. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 添加隐形水印
    /// - Parameter text: 水印
    func addWaterMark(text: String, size: CGSize) -> UIImage? {
        let font = UIFont.systemFont(ofSize: 18)
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.01)];
        var newImage = self.copy() as! UIImage
        var x: CGFloat = 0
        var y: CGFloat = 0
        var idx0: CGFloat = 0
        var idx1: CGFloat = 0
        let textSize = (text as NSString).size(withAttributes: attributes)
        while y < size.height {
            y = textSize.height * 2 * idx1;
            while x < size.width {
                autoreleasepool {
                    x = textSize.width * 2 * idx0
                    if let image = addWatermark(image: newImage, size: size, text: text, textPoint: CGPoint(x: x, y: y), attributes: attributes) {
                        newImage = image
                    }
                }
                idx0 += 1
            }
            x = 0
            idx0 = 0
            idx1 += 1
        }
        return newImage
    }
    
    private func addWatermark(image: UIImage, size: CGSize, text: String, textPoint: CGPoint, attributes: [NSAttributedString.Key: Any]) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.draw(in: CGRect(origin: CGPoint(), size: size))
        let textSize = (text as NSString).size(withAttributes: attributes)
        (text as NSString).draw(in: CGRect(x: textPoint.x, y: textPoint.y, width: textSize.width, height: textSize.height), withAttributes: attributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

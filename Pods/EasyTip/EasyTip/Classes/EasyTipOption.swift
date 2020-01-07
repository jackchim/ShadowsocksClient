//
//  EasyTipOption.swift
//  EasyTip
//
//  Created by Ning Li on 2020/1/6.
//  Copyright © 2020 ningli. All rights reserved.
//

import UIKit

public struct EasyTipOption {
    /// 背景色
    public let backgroundColor: UIColor
    /// 阴影
    public let shadow: EasyTipShadow?
    /// 文本字体
    public let textFont: UIFont
    /// 文本颜色
    public let textColor: UIColor
    /// 文本对齐方式
    public let textAligment: NSTextAlignment
    /// 向上轻扫 dismiss
    public var isEnableSwipeDismiss = true
    
    public static let `default` = EasyTipOption(backgroundColor: UIColor.white,
                                         shadow: .default,
                                         textFont: UIFont.systemFont(ofSize: 15),
                                         textColor: UIColor.black,
                                         textAligment: .left)
}

/// 阴影
public struct EasyTipShadow {
    public let shadowOffset: CGSize
    public let shadowOpacity: Float
    public let shadowRadius: CGFloat
    public let shadowColor: CGColor
    
    public static let `default` = EasyTipShadow(shadowOffset: CGSize.zero, shadowOpacity: 0.4, shadowRadius: 4, shadowColor: UIColor.gray.cgColor)
}

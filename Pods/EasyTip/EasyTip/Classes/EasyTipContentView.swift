//
//  EasyTipContentView.swift
//  EasyTip
//
//  Created by Ning Li on 2020/1/6.
//  Copyright © 2020 ningli. All rights reserved.
//

import UIKit

private let kEasyTipContentViewHeight: CGFloat = 44

public class EasyTipContentView: UIView {
    
    private let option: EasyTipOption
    private var complete: EasyTipComplete?
    private var isDismiss: Bool = false
    
    public init(image: UIImage?, message: String?, option: EasyTipOption, complete: EasyTipComplete?) {
        self.option = option
        self.complete = complete
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let rect = CGRect(x: 0, y: -kEasyTipContentViewHeight - statusBarHeight, width: UIScreen.main.bounds.width, height: kEasyTipContentViewHeight + statusBarHeight)
        super.init(frame: rect)
        
        setupUI(size: rect.size, image: image, message: message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(size: CGSize, image: UIImage?, message: String?) {
        backgroundColor = UIColor.clear
        
        // 背景
        let rect = CGRect(origin: CGPoint.zero, size: CGSize(width: size.width, height: size.height + 10))
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.fillColor = option.backgroundColor.cgColor
        backgroundLayer.frame = CGRect(x: 0, y: -10, width: size.width, height: size.height)
        let backgroundPath = UIBezierPath(roundedRect: rect, cornerRadius: 0)
        backgroundLayer.path = backgroundPath.cgPath
        layer.addSublayer(backgroundLayer)
        
        // 提示文本
        if message != nil || image != nil {
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            let tipLabel = UILabel(frame: CGRect(x: 16, y: statusBarHeight, width: rect.width - 32, height: kEasyTipContentViewHeight))
            if let image = image {
                let text = "  \(message ?? "")"
                let attrM = NSMutableAttributedString(string: text)
                attrM.addAttributes([NSAttributedString.Key.font: option.textFont,
                                     NSAttributedString.Key.foregroundColor: option.textColor],
                                    range: NSMakeRange(0, text.count))
                let textHeight = NSString(string: " ").size(withAttributes: [NSAttributedString.Key.font: option.textFont]).height
                let imageAttachment = NSTextAttachment()
                imageAttachment.image = image
                imageAttachment.bounds = CGRect(origin: CGPoint(x: 0, y: (textHeight - image.size.height) * 0.5 - 2), size: image.size)
                attrM.insert(NSAttributedString(attachment: imageAttachment), at: 0)
                tipLabel.attributedText = attrM.copy() as? NSAttributedString
            } else {
                tipLabel.text = message
                tipLabel.font = option.textFont
                tipLabel.textColor = option.textColor
            }
            tipLabel.textAlignment = option.textAligment
            addSubview(tipLabel)
        }
        
        if let shadow = option.shadow {
            backgroundLayer.shadowColor = shadow.shadowColor
            backgroundLayer.shadowOffset = shadow.shadowOffset
            backgroundLayer.shadowRadius = shadow.shadowRadius
            backgroundLayer.shadowOpacity = shadow.shadowOpacity
            
            let shadowPath = UIBezierPath(rect: rect)
            backgroundLayer.shadowPath = shadowPath.cgPath
        }
        
        if option.isEnableSwipeDismiss {
            addSwipeGeature()
        }
        
        show()
    }
    
    private func addSwipeGeature() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeRecognizer(swipe:)))
        swipe.direction = .up
        addGestureRecognizer(swipe)
    }
}

extension EasyTipContentView {
    private func show() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.frame.origin.y = 0
        }, completion: nil)
    }
    
    public func dismiss() {
        if isDismiss {
            return
        }
        isDismiss = true
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin.y = -kEasyTipContentViewHeight - UIApplication.shared.statusBarFrame.height
        }) { (_) in
            self.complete?()
            self.removeFromSuperview()
        }
    }
}

extension EasyTipContentView {
    @objc private func swipeRecognizer(swipe: UISwipeGestureRecognizer) {
        dismiss()
    }
}

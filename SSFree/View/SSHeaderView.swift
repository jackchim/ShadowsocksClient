//
//  SSHeaderView.swift
//  SSFree
//
//  Created by Ning Li on 2020/1/8.
//  Copyright © 2020 Ning Li. All rights reserved.
//

import UIKit

class SSHeaderView: UIView {
    
    private lazy var imageView = UIImageView(image: UIImage(named: "img_background"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        insertSubview(imageView, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}

//
//  YDFixTabBar.swift
//  中国·宁夏
//
//  Created by yudai on 2017/12/3.
//  Copyright © 2017年 拓尔思. All rights reserved.
//  用于修复iPhone X PUSH时tabBar上移的Bug

import UIKit

class YDFixTabBar: UITabBar {

    override var frame: CGRect {
        didSet{
            if (superview != nil) && superview?.bounds.maxY != frame.maxY {
                frame.origin.y = (superview?.bounds.height)! - frame.height
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isTranslucent = true
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

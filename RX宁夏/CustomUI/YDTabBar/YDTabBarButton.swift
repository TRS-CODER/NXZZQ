//
//  YDTabBarButton.swift
//  中国·宁夏
//
//  Created by yudai on 2017/12/1.
//  Copyright © 2017年 拓尔思. All rights reserved.
//

import UIKit

class YDTabBarButton: UIButton {

    private var itemModel: YDTabBarItemModel?
    
    // 屏蔽按钮高亮效果
    override var isHighlighted: Bool {
        get{ return false }
        set{ }
    }
    
    convenience init(itemModel: YDTabBarItemModel) {
        self.init(frame: CGRect.zero)
        self.itemModel = itemModel
        
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRect(x: (bounds.width - kImageWH) / 2, y: kImageY, width: kImageWH, height: kImageWH)
        titleLabel?.frame = CGRect(x: 0, y: (imageView?.frame.maxY)! + 5, width: bounds.width, height: kTitleH)
    }
}

extension YDTabBarButton {
    
    private func setupUI() {
        setImage(UIImage(named: (itemModel?.image)!), for: .normal)
        setImage(UIImage(named: (itemModel?.imageSelected)!), for: .selected)
        setTitle(itemModel?.title, for: .normal)
        titleLabel?.textAlignment = .center
        setTitleColor(kTitleNormalC, for: .normal)
        setTitleColor(kTitleSelectedC, for: .selected)
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    /** 添加点击图片抖动效果 */
    open func bounceEffect() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.imageView?.layer.setAffineTransform(CGAffineTransform(scaleX: 0.8,y: 0.8))
        }) { (_) in
            self.imageView?.layer.setAffineTransform(CGAffineTransform.identity)
        }
    }
}








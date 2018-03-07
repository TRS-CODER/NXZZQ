//
//  NXDetailNavBar.swift
//  RX宁夏
//
//  Created by yudai on 2018/3/6.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

// MARK:- 常量
fileprivate struct Metric {
    
    static let homeBarW: CGFloat = kScreenW
    static let homeBarH: CGFloat = kNavBarH()
}

class NXDetailNavBar: NXBaseNavBar {

    typealias AddBlock = (_ model: YDNavigationBarItemModel) -> Void
    var itemClicked: AddBlock? = { (_) in
        return
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }

}

extension NXDetailNavBar: YDNavUniversalable {
    
    private func initUI() {
        // 返回
        let back = self.universal(model: YDNavigationBarItemMetric.back) { (model) in
            self.itemClicked!(model)
        }
        
        // 字体
        let font = self.universal(model: YDNavigationBarItemMetric.font) { (model) in
            self.itemClicked!(model)
        }
        
        // logo
        let logo = self.universal(model: YDNavigationBarItemMetric.logo)
        
        // 布局(只需要位置)
        back.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        font.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottomMargin.equalTo(-8)
        }
        
        logo.snp.makeConstraints { (make) in
            make.centerY.equalTo(back.snp.centerY)
            make.centerX.equalToSuperview()
        }
    }
    
}







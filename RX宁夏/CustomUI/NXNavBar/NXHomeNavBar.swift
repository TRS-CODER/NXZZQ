//
//  NXHomeNavBar.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/6.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

// MARK:- 常量
fileprivate struct Metric {
    
    static let homeBarW: CGFloat = kScreenW
    static let homeBarH: CGFloat = kNavBarH()
}

class NXHomeNavBar: NXBaseNavBar {
    
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

extension NXHomeNavBar: YDNavUniversalable {
    private func initUI() {
        // 个人中心
        let profile = self.universal(model: YDNavigationBarItemMetric.profile) { (model) in
            self.itemClicked!(model)
        }
        
        // 搜索
        let search = self.universal(model: YDNavigationBarItemMetric.search) { (model) in
            self.itemClicked!(model)
        }
        
        // logo
        let logo = self.universal(model: YDNavigationBarItemMetric.logo)
        
        // 布局(只需要位置)
        profile.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        search.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottomMargin.equalTo(-8)
        }
        
        logo.snp.makeConstraints { (make) in
            make.centerY.equalTo(search.snp.centerY)
            make.centerX.equalToSuperview()
        }
    }
}

















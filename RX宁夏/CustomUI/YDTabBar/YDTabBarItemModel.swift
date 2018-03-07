//
//  YDTabBarItemModel.swift
//  中国·宁夏
//
//  Created by yudai on 2017/12/1.
//  Copyright © 2017年 拓尔思. All rights reserved.
//

import UIKit

@objcMembers

class YDTabBarItemModel: NSObject {

    var title = ""
    var image = ""
    var imageSelected = ""
    var destVC = ""
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}

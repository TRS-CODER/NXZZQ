//
//  YDNibLoadable.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/6.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

protocol NibLoadable { }

extension NibLoadable where Self : UIView {
    
    static func loadFromNib(_ nibNmae :String? = nil) -> Self {
        return Bundle.main.loadNibNamed(nibNmae ?? "\(self)", owner: nil, options: nil)?.first as! Self
    }
}


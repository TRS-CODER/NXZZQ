//
//  NXToolbar.swift
//  中国·宁夏
//
//  Created by yudai on 2017/11/27.
//  Copyright © 2017年 拓尔思. All rights reserved.
//

/**
    点击事件定义
    tag = 0 收藏
    tag = 1 分享
 */

import UIKit

class NXToolbar: UIView {
    

    @IBOutlet weak var collectBtn: UIButton!
    
    /** 工具条收藏点击闭包 */
    open var toolBarCollectionClosure: ((_ btn : UIButton) -> Void)?
    /** 工具条分享点击闭包 */
    open var toolBarShareClosure: (() -> Void)?
    
    class func toolbar() -> NXToolbar {
        return Bundle.main.loadNibNamed("NXToolbar", owner: nil, options: nil)?.last as! NXToolbar
    }

    @IBAction func toolbarDidClick(_ btn: UIButton) {
        switch btn.tag {
        case 0:
            toolBarCollectionClosure?(collectBtn)
        case 1:
            toolBarShareClosure?()
        default:
            break
        }
    }
}

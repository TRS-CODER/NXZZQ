//
//  NXOnlineAffImageHeader.swift
//  中国·宁夏
//
//  Created by yudai on 2017/11/29.
//  Copyright © 2017年 拓尔思. All rights reserved.
//

import UIKit

let kNXOnlineAffImageHeaderID = "kNXOnlineAffImageHeaderID"

let NXOnlineAffImageHeaderImageH : CGFloat = kScreenW / 16 * 9

class NXOnlineAffImageHeader: UICollectionReusableView {
    
    var model: NXCommonSectionModel? {
        didSet{
            titleLabel.text = model?.channelTitle
        }
    }
    
    var imageUrl: String? {
        didSet{
            YDWebImageTool.setImage(with: imageUrl!, needsSetImageView: iconView, placeholder: nil)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconView: UIImageView!
    
}

//
//  YDCommonItem.swift
//  RX宁夏
//
//  Created by yudai on 2018/3/5.
//  Copyright © 2018年 拓尔思. All rights reserved.
//  项目中运用很多的一种collectionViewCell (图片在上文字在下)

import UIKit
import SnapKit

public let YDCommonItemID = "YDCommonItemID"
public let YDCommonItemH: CGFloat = kInch58() ? 120 : kInch55() ? 115 : 105
public let YDCommonItemW: CGFloat = (kScreenW - (2 * kNXMargin)) / 4

class YDCommonItem: UICollectionViewCell {
    
    open var model: NXCommonModel? {
        didSet{
            YDWebImageTool.setImage(with: (model?.docImages![0])!, needsSetImageView: iconView, placeholder: nil)
            titleLabel.text = model?.docTitle
        }
    }
    
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = UIColor.black
        tl.textAlignment = .center
        return tl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
}

extension YDCommonItem {
    private func initUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        
        iconView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(iconView.snp.width)
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
    }
}


















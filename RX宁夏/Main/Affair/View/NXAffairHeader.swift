//
//  NXAffairHeader.swift
//  RX宁夏
//
//  Created by yudai on 2018/3/5.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

let NXAffairHeaderID = "NXAffairHeaderID"
class NXAffairHeader: UICollectionReusableView {
    
    open var model: NXCommonSectionModel? {
        didSet{
            titleLabel.text = model?.channelTitle
        }
    }
    
    private lazy var leftView: UIView = {
        let lv = UIView()
        lv.backgroundColor = kBlueC
        return lv
    }()
    
    private lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = kBlueC
        tl.numberOfLines = 1
        tl.font = UIFont.systemFont(ofSize: 15)
        return tl
    }()
    
    private lazy var separateLine: UIView = {
        let sl = UIView()
        sl.backgroundColor = kSeparateLineC
        return sl
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

extension NXAffairHeader {
    private func initUI() {
        backgroundColor = UIColor.white
        
        addSubview(leftView)
        addSubview(titleLabel)
        addSubview(separateLine)
        
        leftView.snp.makeConstraints { (make) in
            make.left.equalTo(kNXMargin)
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
            make.width.equalTo(5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftView.snp.right).offset(kNXMargin)
            make.centerY.equalTo(leftView)
        }
        
        separateLine.snp.makeConstraints { (make) in
            make.left.equalTo(kNXMargin)
            make.right.equalTo(-kNXMargin)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

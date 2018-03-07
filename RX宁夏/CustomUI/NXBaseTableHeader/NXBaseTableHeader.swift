//
//  NXBaseTableHeader.swift
//  RX宁夏
//
//  Created by yudai on 2018/3/1.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

class NXBaseTableHeader: UIView {
    
    private var dataSource: NXCommonHeaderModel!
    
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let tl = UILabel(frame: CGRect.zero)
        tl.textColor = UIColor.black
        tl.font = UIFont.systemFont(ofSize: 18)
        tl.numberOfLines = 2
        return tl
    }()
    
    private lazy var briefField: UITextView = {
        let bf = UITextView()
        bf.font = UIFont.systemFont(ofSize: 12)
        bf.textColor = UIColor.lightGray
        return bf
    }()
    
    private lazy var chairmanList: NXChairmanList = {
        let cl = NXChairmanList(dataSource: dataSource.references!)
        return cl
    }()
    
    private lazy var cochairmanList: NXCochairmanList = {
        let cl = NXCochairmanList(dataSource: dataSource.leaders!)
        return cl
    }()
    
    private lazy var separateLine: UIView = {
        let sl = UIView()
        sl.backgroundColor = kSeparateLineC
        return sl
    }()
    
    init(dataSource: NXCommonHeaderModel) {
        super.init(frame: CGRect.zero)
        self.dataSource = dataSource
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NXBaseTableHeader {
    private func initUI() {
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(briefField)
        addSubview(separateLine)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(kNXMargin)
            make.top.equalTo(iconView)
            make.right.equalTo(-kNXMargin)
        }
        
        briefField.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel).offset(-2) // 对齐titleLabel
            make.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(kNXMargin)
            make.bottom.equalTo(iconView)
        }
        
        iconView.snp.makeConstraints { (make) in
            make.left.top.equalTo(kNXMargin)
            make.height.equalTo(iconView.snp.width).multipliedBy(3.5/2.5)
            make.width.equalTo(88)
        }
        
        separateLine.snp.makeConstraints { (make) in
            make.left.equalTo(kNXMargin)
            make.right.equalTo(-kNXMargin)
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
        
        if dataSource.references != nil { // 主席样式
            addSubview(chairmanList)
            chairmanList.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(iconView.snp.bottom).offset(kNXMargin)
                make.bottom.equalTo(-kNXMargin)
            }
        } else if dataSource.leaders != nil { // 副主席xiang
            addSubview(cochairmanList)
            cochairmanList.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(iconView.snp.bottom).offset(kNXMargin)
                make.bottom.equalTo(-kNXMargin)
            }
        }
        
        updateUI()
    }
    
    private func updateUI() {
        YDWebImageTool.setImage(with: dataSource.docImages![0], needsSetImageView: iconView, placeholder: nil)
        titleLabel.text = dataSource.docTitle
        briefField.text = dataSource.docContent
    }
}




















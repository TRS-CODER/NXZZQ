//
//  NXCommonHeader.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/26.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit
import SnapKit

let kNXCommonHeaderID = "kNXCommonHeaderID"
class NXCommonHeader: UITableViewHeaderFooterView {
    
    open var sectionModel: NXCommonSectionModel? {
        didSet{
            titleLabel.text = sectionModel?.channelTitle
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
    
    private lazy var moreBtn: NXHeaderBtn = {
        let mb = NXHeaderBtn()
        mb.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        mb.setTitle("更多", for: .normal)
        mb.setImage(UIImage(named: "newstable_more@3x"), for: .normal)
        mb.setTitleColor(UIColor.black, for: .normal)
        return mb 
    }()
    
    private lazy var separateLine: UIView = {
        let sl = UIView()
        sl.backgroundColor = kSeparateLineC
        return sl
    }()
    
    class func headerView(tableView: UITableView) -> NXCommonHeader {
        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: kNXCommonHeaderID)
        if header == nil {
            header = NXCommonHeader(reuseIdentifier: kNXCommonHeaderID)
        }
        return header as! NXCommonHeader
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: kNXCommonHeaderID)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
    
}

extension NXCommonHeader {
    private func initUI() {
        contentView.backgroundColor = UIColor.white
        
        contentView.addSubview(leftView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(separateLine)
        contentView.addSubview(moreBtn)
        
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
        
        moreBtn.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(leftView)
            make.right.equalTo(-kNXMargin)
        }
        
        separateLine.snp.makeConstraints { (make) in
            make.left.equalTo(kNXMargin)
            make.right.equalTo(-kNXMargin)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

class NXHeaderBtn: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.bounds.width)!
    }
}




















//
//  NXProfileCell.swift
//  RX宁夏
//
//  Created by yudai on 2018/3/6.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

let NXProfileCellID = "NXProfileCellID"

let NXProfileCellH : CGFloat = kInch58() ? 56 : kInch55() ? 52 : kInch47() ? 50 : 44

class NXProfileCell: UITableViewCell {
    
    open var title: String? {
        didSet{
            titleLabel.text = title
        }
    }

    private lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.black
        tl.font = UIFont.systemFont(ofSize: 18)
        tl.textAlignment = .left
        tl.backgroundColor = UIColor.clear
        return tl
    }()

    private lazy var arrowView: UIImageView = {
        let av = UIImageView(image: UIImage(named: "profile_arrow"))
        return av
    }()
   
    class func tableViewCell(tableView: UITableView) -> NXProfileCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: NXProfileCellID)
        if cell == nil {
            cell = NXProfileCell(style: .default, reuseIdentifier: NXProfileCellID)
        }
        return cell as! NXProfileCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
    
}

extension NXProfileCell {
    private func initUI() {
        backgroundColor = UIColor.clear
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        arrowView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(10)
        }
    }
}




















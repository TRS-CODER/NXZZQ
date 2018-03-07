//
//  YDRightImageCell.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/27.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit
import SnapKit

class YDRightImageCell: UITableViewCell {
    
    open var model: NXCommonModel? {
        didSet{
            titleLabel.text = model?.docTitle
            YDWebImageTool.setImage(with: (model?.docImages![0])!, needsSetImageView: iconView, placeholder: nil)
            subTitleLabel.text = model?.docTime
        }
    }

    private lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: YDCellTitleFontSize)
        tl.textColor = YDCellTitleColor
        tl.numberOfLines = YDCellTitleLines
        return tl
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let st = UILabel()
        st.font = UIFont.systemFont(ofSize: YDCellSubTitleFontSize)
        st.textColor = YDCellSubTitleColor
        st.numberOfLines = YDCellSubTitleLines
        return st
    }()
    
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.yellow
        return iv
    }()
    
    private lazy var separateLine: UIView = {
        let sl = UIView()
        sl.backgroundColor = YDCellSeparateLineColor
        return sl
    }()
    
    class func tableViewCell(tableView: UITableView) -> YDRightImageCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: YDRightImageCellID)
        if cell == nil {
            cell = YDRightImageCell(style: .default, reuseIdentifier: YDRightImageCellID)
        }
        return cell as! YDRightImageCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension YDRightImageCell {
    
    private func initUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconView)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(separateLine)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(YDCellMargin)
            make.right.equalTo(iconView.snp.left).offset(-YDCellMargin)
        }
        
        iconView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-YDCellMargin)
            make.top.equalTo(YDCellMargin)
            make.width.equalTo(YDRightImageCellImageW)
            make.height.equalTo(iconView.snp.width).multipliedBy(YDRightImageCellImageRadio)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(iconView.snp.bottom)
        }
        
        separateLine.snp.makeConstraints { (make) in
            make.height.equalTo(YDCellSeparateLineH)
            make.bottom.equalToSuperview()
            make.left.equalTo(YDCellMargin)
            make.right.equalTo(-YDCellMargin)
        }
    }

}





















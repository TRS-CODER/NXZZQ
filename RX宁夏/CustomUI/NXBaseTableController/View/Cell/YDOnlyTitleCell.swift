//
//  YDOnlyTitleCell.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/27.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

let YDOnlyTitleCellID = "YDOnlyTitleCellID"
class YDOnlyTitleCell: UITableViewCell {
    
    open var model: NXCommonModel? {
        didSet{
            titleLabel.text = model?.docTitle
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
    
    private lazy var separateLine: UIView = {
        let sl = UIView()
        sl.backgroundColor = YDCellSeparateLineColor
        return sl
    }()
    
    class func tableViewCell(tableView: UITableView) -> YDOnlyTitleCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: YDOnlyTitleCellID)
        if cell == nil {
            cell = YDOnlyTitleCell(style: .default, reuseIdentifier: YDOnlyTitleCellID)
        }
        return cell as! YDOnlyTitleCell
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

extension YDOnlyTitleCell {
    
    private func initUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(separateLine)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(YDCellMargin)
            make.right.equalTo(-YDCellMargin)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(YDCellMargin)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(-YDCellMargin)
        }
        
        separateLine.snp.makeConstraints { (make) in
            make.height.equalTo(YDCellSeparateLineH)
            make.bottom.equalToSuperview()
            make.left.equalTo(YDCellMargin)
            make.right.equalTo(-YDCellMargin)
        }
    }
    
}





















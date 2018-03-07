//
//  YDComplexCell.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/27.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

let YDComplexCellID = "YDComplexCellID"
let YDComplexCellTitleW: CGFloat = UILabel.getLabelWidth("我是占位:", YDCellSubTitleFontSize, 999)
class YDComplexCell: UITableViewCell {
    
    open var model: NXCommonModel? {
        didSet{
            titleLabel.text = model?.docTitle
            tipsLabela.text = model?.interviewee
            tipsLabelb.text = model?.interviewTime
            tipsLabelc.text = model?.intervieweeResume
            tipsLabeld.text = model?.interviewContent
            YDWebImageTool.setImage(with: model!.docImages![0], needsSetImageView: iconView, placeholder: nil)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: YDCellTitleFontSize)
        tl.textColor = YDCellTitleColor
        tl.numberOfLines = YDCellTitleLines
        return tl
    }()
    
    private lazy var tipsLabel1: UILabel = {
        let st = UILabel()
        st.font = UIFont.systemFont(ofSize: YDCellSubTitleFontSize)
        st.textColor = YDCellSubTitleColor
        st.numberOfLines = YDCellSubTitleLines
        st.text = "嘉宾姓名:"
        return st
    }()
    
    private lazy var tipsLabela: UILabel = {
        let st = UILabel()
        st.font = UIFont.systemFont(ofSize: YDCellSubTitleFontSize)
        st.textColor = YDCellTitleColor
        st.numberOfLines = YDCellSubTitleLines
        return st
    }()
    
    private lazy var tipsLabel2: UILabel = {
        let st = UILabel()
        st.font = UIFont.systemFont(ofSize: YDCellSubTitleFontSize)
        st.textColor = YDCellSubTitleColor
        st.numberOfLines = YDCellSubTitleLines
        st.text = "访谈时间:"
        return st
    }()
    
    private lazy var tipsLabelb: UILabel = {
        let st = UILabel()
        st.font = UIFont.systemFont(ofSize: YDCellSubTitleFontSize)
        st.textColor = YDCellTitleColor
        st.numberOfLines = YDCellSubTitleLines
        return st
    }()
    
    private lazy var tipsLabel3: UILabel = {
        let st = UILabel()
        st.font = UIFont.systemFont(ofSize: YDCellSubTitleFontSize)
        st.textColor = YDCellSubTitleColor
        st.numberOfLines = YDCellSubTitleLines
        st.text = "嘉宾简介:"
        return st
    }()
    
    private lazy var tipsLabelc: UILabel = {
        let st = UILabel()
        st.font = UIFont.systemFont(ofSize: YDCellSubTitleFontSize)
        st.textColor = YDCellTitleColor
        st.numberOfLines = YDCellSubTitleLines
        return st
    }()
    
    private lazy var tipsLabel4: UILabel = {
        let st = UILabel()
        st.font = UIFont.systemFont(ofSize: YDCellSubTitleFontSize)
        st.textColor = YDCellSubTitleColor
        st.numberOfLines = YDCellSubTitleLines
        st.text = "访谈简介:"
        return st
    }()
    
    private lazy var tipsLabeld: UILabel = {
        let st = UILabel()
        st.font = UIFont.systemFont(ofSize: YDCellSubTitleFontSize)
        st.textColor = YDCellTitleColor
        st.numberOfLines = 2
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
    
    class func tableViewCell(tableView: UITableView) -> YDComplexCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: YDComplexCellID)
        if cell == nil {
            cell = YDComplexCell(style: .default, reuseIdentifier: YDComplexCellID)
        }
        return cell as! YDComplexCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension YDComplexCell {
    
    private func initUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconView)
        contentView.addSubview(tipsLabel1)
        contentView.addSubview(tipsLabel2)
        contentView.addSubview(tipsLabel3)
        contentView.addSubview(tipsLabel4)
        contentView.addSubview(tipsLabela)
        contentView.addSubview(tipsLabelb)
        contentView.addSubview(tipsLabelc)
        contentView.addSubview(tipsLabeld)
        contentView.addSubview(separateLine)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(YDCellMargin)
            make.right.equalTo(-YDCellMargin)
        }
        
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(YDCellMargin)
            make.left.equalTo(YDCellMargin)
            make.height.equalTo(YDComplexCellImageH)
            make.width.equalTo(iconView.snp.height).multipliedBy(YDComplexCellImageRadio)
        }
        
        tipsLabel1.snp.makeConstraints { (make) in
            make.top.equalTo(iconView)
            make.left.equalTo(iconView.snp.right).offset(YDCellMargin)
            make.height.equalTo(25)
            // 自适应宽度有问题需要手动添加
            make.width.equalTo(YDComplexCellTitleW)
        }
        
        tipsLabela.snp.makeConstraints { (make) in
            make.centerY.equalTo(tipsLabel1)
            make.left.equalTo(tipsLabel1.snp.right).offset(YDCellMargin)
            make.right.equalTo(-YDCellMargin)
        }
        
        tipsLabel2.snp.makeConstraints { (make) in
            make.top.equalTo(tipsLabel1.snp.bottom)
            make.left.equalTo(tipsLabel1)
            make.height.equalTo(25)
            make.width.equalTo(YDComplexCellTitleW)
        }
        
        tipsLabelb.snp.makeConstraints { (make) in
            make.centerY.equalTo(tipsLabel2)
            make.left.equalTo(tipsLabel2.snp.right).offset(YDCellMargin)
            make.right.equalTo(-YDCellMargin)
        }
        
        tipsLabel3.snp.makeConstraints { (make) in
            make.top.equalTo(tipsLabel2.snp.bottom)
            make.left.equalTo(tipsLabel1)
            make.height.equalTo(25)
            make.width.equalTo(YDComplexCellTitleW)
        }
        
        tipsLabelc.snp.makeConstraints { (make) in
            make.centerY.equalTo(tipsLabel3)
            make.left.equalTo(tipsLabel3.snp.right).offset(YDCellMargin)
            make.right.equalTo(-YDCellMargin)
        }
        
        tipsLabel4.snp.makeConstraints { (make) in
            make.left.equalTo(YDCellMargin)
            make.top.equalTo(iconView.snp.bottom).offset(YDCellMargin)
            make.width.equalTo(YDComplexCellTitleW)
        }
        
        tipsLabeld.snp.makeConstraints { (make) in
            make.top.equalTo(tipsLabel4)
            make.left.equalTo(tipsLabel4.snp.right).offset(YDCellMargin)
            make.right.equalTo(-YDCellMargin)
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




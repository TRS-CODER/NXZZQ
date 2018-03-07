//
//  NXInstitutionCell.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/27.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

let NXInstitutionCellID = "NXInstitutionCellID"
let NXInstitutionSubCellMargin: CGFloat = kNXMargin
let NXInstitutionSubCellFontSize: CGFloat = 14
let NXInstitutionSubCellEdgeInsets: CGFloat = 5

class NXInstitutionCell: UITableViewCell {
    
    open var dataSource: [NXCommonModel]!
    
    private lazy var separateLine: UIView = {
        let sl = UIView()
        sl.backgroundColor = YDCellSeparateLineColor
        return sl
    }()

    class func tableViewCell(tableView: UITableView, dataSource: [NXCommonModel]) -> NXInstitutionCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: NXInstitutionCellID)
        if cell == nil {
            cell = NXInstitutionCell(style: .default, reuseIdentifier: NXInstitutionCellID, dataSource: dataSource)
        }
        return cell as! NXInstitutionCell
    }
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, dataSource: [NXCommonModel]) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        self.dataSource = dataSource
        initUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension NXInstitutionCell {
    
    private func initUI() {
        
        let containerViews = dataSource.map { (sectionModel) -> UIView in
            let containerView = UIView()
            contentView.addSubview(containerView)
            makeConstraints(containerView: containerView, sectionModel: sectionModel)
            return containerView
        }
        
        for (i,containerView) in containerViews.enumerated() {
            if i == 0 { // 第一个容器
                containerView.snp.makeConstraints({ (make) in
                    make.left.top.width.equalToSuperview()
                    if containerViews.count == 1 { // 有且只有一个section的情况
                        make.bottom.equalToSuperview()
                    }
                })
            } else { // 不是第一个容器
                containerView.snp.makeConstraints({ (make) in
                    make.left.width.equalToSuperview()
                    make.top.equalTo(containerViews[i - 1].snp.bottom)
                    if i == containerViews.count - 1 { // 最后一个
                        make.bottom.equalToSuperview()
                    }
                })
            }
        }
        
        contentView.addSubview(separateLine)
        separateLine.snp.makeConstraints { (make) in
            make.height.equalTo(YDCellSeparateLineH)
            make.bottom.equalToSuperview()
            make.left.equalTo(YDCellMargin)
            make.right.equalTo(-YDCellMargin)
        }
        
    }
    
    // sectionModel: NXCommonModel data: [String : Any]
    private func makeConstraints(containerView: UIView, sectionModel: NXCommonModel) {
        
        // 1. 设置头部标签
        let headerLabel = UILabel()
        headerLabel.font = UIFont.systemFont(ofSize: 17)
        headerLabel.textColor = UIColor(R: 45, G: 93, B: 155, Alpha: 1)
        headerLabel.text = sectionModel.docTitle
        
        containerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(NXInstitutionSubCellMargin)
        }
        
        // 2. 设置子标签数组
        let labelArr =  sectionModel.subItems!.map({ (model) -> UILabel in
            let label = YDEdgeInsetsLabel(edgeInsets: UIEdgeInsetsMake(NXInstitutionSubCellEdgeInsets, NXInstitutionSubCellEdgeInsets, NXInstitutionSubCellEdgeInsets, NXInstitutionSubCellEdgeInsets))
            label.textColor = UIColor.black
            label.text = model.itemTitle
            label.backgroundColor = UIColor(R: 243, G: 243, B: 243, Alpha: 1)
            label.numberOfLines = 1
            label.font = UIFont.systemFont(ofSize: NXInstitutionSubCellFontSize)
            containerView.addSubview(label)
            return label
        })
        
        /** 记录当前最大的X值 */
        var currentMaxX: CGFloat = 0
        
        for (i,label) in labelArr.enumerated() {
            label.snp.makeConstraints({ (make) in
                if i == 0 { // 第一个标签
                    make.left.equalTo(NXInstitutionSubCellMargin)
                    make.top.equalTo(headerLabel.snp.bottom).offset(NXInstitutionSubCellMargin)
                    make.right.lessThanOrEqualTo(-NXInstitutionSubCellMargin)
                    currentMaxX = NXInstitutionSubCellMargin + UILabel.getLabelWidth(labelArr[0].text!, NXInstitutionSubCellFontSize, 999) + 2*NXInstitutionSubCellEdgeInsets
                    if labelArr.count == 1 { // 有且只有一个标签
                        make.bottom.equalTo(-NXInstitutionSubCellMargin)
                    }
                } else { // 不是第一个标签
                    let desireMaxX = currentMaxX + NXInstitutionSubCellMargin + UILabel.getLabelWidth(label.text!, NXInstitutionSubCellFontSize, 999) + 2*NXInstitutionSubCellEdgeInsets + NXInstitutionSubCellMargin
                    if desireMaxX > kScreenW { // 超出屏幕
                        make.top.equalTo(labelArr[i - 1].snp.bottom).offset(NXInstitutionSubCellMargin)
                        make.left.equalTo(NXInstitutionSubCellMargin)
                        // 重设当前最大宽度
                        currentMaxX = NXInstitutionSubCellMargin + UILabel.getLabelWidth(labelArr[i].text!, NXInstitutionSubCellFontSize, 999) + 2*NXInstitutionSubCellEdgeInsets
                    } else { // 没有超出屏幕
                        make.left.equalTo(labelArr[i - 1].snp.right).offset(NXInstitutionSubCellMargin)
                        make.top.equalTo(labelArr[i - 1])
                        // 更新最大宽度
                        currentMaxX += NXInstitutionSubCellMargin + UILabel.getLabelWidth(labelArr[i].text!, NXInstitutionSubCellFontSize, 999) + 2*NXInstitutionSubCellEdgeInsets
                    }
                    make.right.lessThanOrEqualTo(-NXInstitutionSubCellMargin)
                    if i == labelArr.count - 1 { // 最后一个
                        make.bottom.equalTo(-NXInstitutionSubCellMargin)
                    }
                }
            })
        }
    }
    
}

class YDEdgeInsetsLabel: UILabel {
    
    /** label需要设置的内边距 */
    private var edgeInsets: UIEdgeInsets!
    
    init(edgeInsets: UIEdgeInsets) {
        super.init(frame: CGRect.zero)
        self.edgeInsets = edgeInsets
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, edgeInsets))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= self.edgeInsets.left
        rect.origin.y -= self.edgeInsets.top
        rect.size.width += self.edgeInsets.left + self.edgeInsets.right
        rect.size.height += self.edgeInsets.top + self.edgeInsets.bottom
        return rect
    }
    
}

































//
//  NXCochairmanList.swift
//  RX宁夏
//
//  Created by yudai on 2018/3/1.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

let NXCochairmanListCellW: CGFloat = (kScreenW - kNXMargin*3)/5
let NXCochairmanListCellH: CGFloat = 30

class NXCochairmanList: UIView {

    private var dataSource: [NXCommonHeaderLeaderTeamModel]!

    private lazy var leftTitle: UILabel = {
        let lt = UILabel()
        lt.backgroundColor = kSeparateLineC
        lt.font = UIFont.systemFont(ofSize: 13)
        lt.layer.borderWidth = 0.5
        lt.layer.borderColor = UIColor.lightGray.cgColor
        lt.textAlignment = .center
        lt.text = "副主席"
        return lt
    }()
    
    private lazy var listView: UIView = {
        let lv = UIView()
        return lv
    }()
    
    init(dataSource: [NXCommonHeaderLeaderTeamModel]) {
        super.init(frame: CGRect.zero)
        self.dataSource = dataSource
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NXCochairmanList {
    private func initUI() {
        addSubview(leftTitle)
        leftTitle.snp.makeConstraints { (make) in
            make.left.equalTo(kNXMargin)
            make.top.equalToSuperview()
            make.width.equalTo(NXCochairmanListCellW)
            make.height.equalTo(NXCochairmanListCellH)
        }
        
        addSubview(listView)
        listView.snp.makeConstraints { (make) in
            make.left.equalTo(leftTitle.snp.right).offset(kNXMargin)
            make.right.equalTo(-kNXMargin)
            make.top.equalTo(leftTitle)
            make.bottom.equalToSuperview()
        }
        
        let labelArr = dataSource.map { (model) -> UILabel in
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = UIColor.black
            label.text = model.leaderName
            listView.addSubview(label)
            label.textAlignment = .center
            return label
        }
        
        for (i,label) in labelArr.enumerated() {
            label.snp.makeConstraints({ (make) in
                // 先统一约束宽度高度
                make.width.equalTo(NXCochairmanListCellW)
                make.height.equalTo(NXCochairmanListCellH)
                // 再分别设置特殊情况
                if i == 0 {                                 // 第一个标签
                    make.top.left.equalToSuperview()
                    if labelArr.count == 1 {                // 显然进不到这来
                        make.bottom.equalToSuperview()
                    }
                } else {                                    // 非第一个标签
                    if (i + 1)%5 == 0 {                     // 需要换行
                        make.top.equalTo(labelArr[i - 1].snp.bottom).offset(kNXMargin)
                        make.left.equalToSuperview()
                    } else {                                // 不需要换
                        make.top.equalTo(labelArr[i - 1])
                        make.left.equalTo(labelArr[i - 1].snp.right)
                    }
                    if i == labelArr.count - 1 {            // 到最后一个
                        make.bottom.equalToSuperview()
                    }
                }
            })
        }
        
    }
}














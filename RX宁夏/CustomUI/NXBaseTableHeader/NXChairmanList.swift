//
//  NXChairmanList.swift
//  RX宁夏
//
//  Created by yudai on 2018/3/2.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

let NXChairmanListCellW: CGFloat = (kScreenW - 4*kNXMargin)/3
let NXChairmanListCellH: CGFloat = 30

class NXChairmanList: UIView {

    private var dataSource: [NXCommonHeaderReferenceModel]!
    
    init(dataSource: [NXCommonHeaderReferenceModel]) {
        super.init(frame: CGRect.zero)
        self.dataSource = dataSource
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension NXChairmanList {
    private func initUI() {
        
        let labelArr = dataSource.map { (model) -> UILabel in
            let label = UILabel()
            label.layer.borderColor = UIColor.lightGray.cgColor
            label.layer.borderWidth = 0.5
            label.backgroundColor = kSeparateLineC
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = UIColor.black
            label.text = model.docTitle
            label.textAlignment = .center
            addSubview(label)
            return label
        }
        
        for (i,label) in labelArr.enumerated() {
            label.snp.makeConstraints({ (make) in
                make.width.equalTo(NXChairmanListCellW)
                make.height.equalTo(NXChairmanListCellH)
                if i == 0 {
                    make.top.equalToSuperview()
                    make.left.equalTo(kNXMargin)
                    if labelArr.count == 1 {              // 显然进不到这来
                        make.bottom.equalToSuperview()
                    }
                } else {
                    if (i + 1)%4 == 0 { // 需要换行
                        make.top.equalTo(labelArr[i - 1].snp.bottom).offset(kNXMargin)
                        make.left.equalTo(kNXMargin)
                    } else {                                // 不需要换
                        make.top.equalTo(labelArr[i - 1])
                        make.left.equalTo(labelArr[i - 1].snp.right).offset(kNXMargin)
                    }
                    if i == labelArr.count - 1 {          // 到最后一个
                        make.bottom.equalToSuperview()
                    }
                }
            })
        }
    }
}


















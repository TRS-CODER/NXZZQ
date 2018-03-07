//
//  NXBaseNavBar.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/6.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

class NXBaseNavBar: UIView {

    private var bgImage : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bgImage = UIImageView(image: UIImage(named: "nav_bg"))
        addSubview(bgImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImage.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

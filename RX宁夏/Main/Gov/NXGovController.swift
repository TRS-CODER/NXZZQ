//
//  NXGovController.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/5.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit
import SnapKit

class NXGovController: UIViewController, YDEdgePanable {

    open var edgePanBlock: ((UIScreenEdgePanGestureRecognizer) -> Void)?
    
    private lazy var edgeGes: UIScreenEdgePanGestureRecognizer = {
        let eg = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(gesActivated(ges:)))
        eg.edges = .left
        return eg
    }()
    
    private lazy var commonTable: NXCommonTable = {
        let cl = NXCommonTable(api: kNXGovAPI)
        return cl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initEvent()
    }
    
}

extension NXGovController {
    
    private func initUI() {
        
        addChildViewController(commonTable)
        view.addSubview(commonTable.view)
        
        commonTable.view.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(kNavBarH())
            make.bottom.equalTo(-kTabBarH())
        }
    }
    
    private func initEvent() {
        view.addGestureRecognizer(edgeGes)
    }

    @objc private func gesActivated(ges: UIScreenEdgePanGestureRecognizer) {
        edgePanBlock?(ges)
    }
    
}





















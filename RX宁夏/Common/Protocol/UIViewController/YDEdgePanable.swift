//
//  YDEdgePanable.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/22.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

protocol YDEdgePanable where Self: UIViewController {
    /// 边缘手势回调
    var edgePanBlock: ((UIScreenEdgePanGestureRecognizer) -> Void)? { set get }
}

//extension YDEdgePanable where Self: UIViewController {
//    func addPanGes2View() {
//        let ges = UIScreenEdgePanGestureRecognizer(target: Self, action: #selector(xx))
//        ges.edges = .left
//
//    }
//
//    @objc func xx()
//}


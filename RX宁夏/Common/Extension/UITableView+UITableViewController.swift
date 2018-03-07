//
//  UITableView+UITableViewController.swift
//  ENJOY
//
//  Created by yudai on 2018/1/10.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// 隐藏Tabview多余cell的分割线
    public func hideMoreSeparate() {
        self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
    }
    
    /// set the tableHeaderView so that the required height can be determined, update the header's frame and set it again
    /// snapKit 自适应头部frame不对的时候用于修正的函数
    func setAndLayoutTableHeaderView(header: UIView) {
        self.tableHeaderView = header
        header.setNeedsLayout()
        header.layoutIfNeeded()
        header.frame.size = header.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        self.tableHeaderView = header
    }
}

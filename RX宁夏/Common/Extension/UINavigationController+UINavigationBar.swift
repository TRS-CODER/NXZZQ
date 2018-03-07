//
//  UINavigationController+UINavigationBar.swift
//  ENJOY
//
//  Created by yudai on 2018/1/10.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /// 快捷为当前导航控制器所属控制器添加全屏pop手势
    ///
    /// - Returns: 系统私有转场对象
    @discardableResult
    public func addFullScreenPop() -> NSObject? {
        
        guard let systemGes = self.interactivePopGestureRecognizer else {
            return nil
        }
        guard let gesView = systemGes.view else {
            return nil
        }
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {
            return nil
        }
        guard let target = targetObjc.value(forKey: "target") else {
            return nil
        }
        let action = Selector(("handleNavigationTransition:"))
        let panGes = UIPanGestureRecognizer()
        panGes.addTarget(target, action: action)
        gesView.addGestureRecognizer(panGes)
        
        return target as? NSObject
    }
}

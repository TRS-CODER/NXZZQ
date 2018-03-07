//
//  NXMainTabBarController.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/5.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

class NXMainTabBarController: UITabBarController {
    
    open var edgePanBlock: ((UIScreenEdgePanGestureRecognizer) -> Void)?
    
    open var profileClickedBlock: (() -> Void)?
    
    private let navBar = NXHomeNavBar()
    
    /** 自定义tabbar */
    private lazy var tabbar: YDTabBar = {
        let tb = YDTabBar(frame: tabBar.bounds)
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initEvent()
    }

}

extension NXMainTabBarController {
    private func initUI() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.width.equalTo(kScreenW)
            make.height.equalTo(kNavBarH())
        }
        delegate = self
        // 修复iPhone X Tabbar上移BUG
        setValue(YDFixTabBar(), forKey: "tabBar")
        // 设置子控制器
        tabbar.tabbarModels.forEach {
            let destVC = NSObject.createVC($0.destVC)
            addChildViewController(destVC!)
        }
        // 设置tabbar
        tabBar.subviews.forEach { $0.removeFromSuperview() }
        tabBar.addSubview(tabbar)
        tabbar.selectedIndex = 0
    }
    
    private func initEvent() {
        for (index,vc) in childViewControllers.enumerated() {
            if index == 0 {
                (vc as! NXHomeController  ).edgePanBlock = { [weak self] (ges) in self?.edgePanBlock?(ges) }
            } else if index == 1 {
                (vc as! NXGovController   ).edgePanBlock = { [weak self] (ges) in self?.edgePanBlock?(ges) }
            } else {
                (vc as! NXAffairController).edgePanBlock = { [weak self] (ges) in self?.edgePanBlock?(ges) }
            }
        }
        
        navBar.itemClicked = { [weak self] (model) in
            switch model.type {
            case .profile:
                self?.profileClickedBlock?()
            case .search:
                break
            default: break
            }
        }
    }
}

extension NXMainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard tabbar.selectedIndex != tabBarController.selectedIndex else { return }
        tabbar.selectedIndex = tabBarController.selectedIndex
    }
}

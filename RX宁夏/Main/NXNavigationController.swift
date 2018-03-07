//
//  NXNavigationController.swift
//  中国·宁夏
//
//  Created by yudai on 2017/12/25.
//  Copyright © 2017年 成都拓尔思. All rights reserved.
//

import UIKit
//import SVProgressHUD

class NXNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    /** 转场动画代理对象(必须强引用) */
//    fileprivate lazy var animator: NXProfileAnimator = {
//        let animator = NXProfileAnimator(animationType: .collection)
//        return animator
//    }()
    
    open var popGesActivatedBlock: (() -> Void)?
    
    // life cycle (自定义push pop动画)
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = self
        navigationBar.isHidden = true
    }

//    override init(rootViewController: UIViewController) {
//        super.init(rootViewController: rootViewController)
//        // 移除navigationBar
//        navigationBar.subviews.forEach { $0.removeFromSuperview() }
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
}

// MARK: 调整tabbar
extension NXNavigationController {
//    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        if viewControllers.count != 0 { //避免第一次就被隐藏
//            viewController.hidesBottomBarWhenPushed = true
//        }
//        super.pushViewController(viewController, animated: animated)
//    }
    
//    @objc private func xx() {
//        print("22222")
//    }
}

// MARK: 自定义push动画的情况下寻回pop手势
extension NXNavigationController {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        popGesActivatedBlock?()
        if viewControllers.count <= 1 { // 根目录的情况下
            return false
        }
        return true
    }
}

// MARK: UINavigationControllerDelegate (TODO: 未来可用，用于自定义push和pop动画)
extension NXNavigationController {
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
////        if operation == .push && toVC.isKind(of: NXTsetViewController.self) {
////            animator.isPresenting = true
////            toVC.view.width = kScreenW
////            return animator
////        }
//        print(navigationController.view.frame)
//        print(fromVC.view.frame)
//        print(toVC.view.frame)
//        return nil
//    }
}























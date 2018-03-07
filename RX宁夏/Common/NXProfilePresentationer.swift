//
//  NXProfilePresentationer.swift
//  中国·宁夏
//
//  Created by yudai on 2017/11/30.
//  Copyright © 2017年 拓尔思. All rights reserved.
//

import UIKit

private let kNXProfileVCViewW: CGFloat = kInch58() ? kScreenW * 0.815 : kScreenH * 900 / 1920

/** 执行动画源VC */
enum PresentingVCType {
    case BaseVC
    case ProfileVC
}

class NXProfilePresentationer: UIPresentationController {
    
    /** 是否是设置控制器 */
    var presentingVCType : PresentingVCType?
    
    convenience init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, presentingVCType: PresentingVCType) {
        self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.presentingVCType = presentingVCType
    }
    
    /** 蒙版 */
    fileprivate lazy var maskView: UIView = {
        let maskView = UIView(frame: CGRect.zero)
        maskView.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        containerView?.insertSubview(maskView, at: 0)
        
        let ges = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        maskView.addGestureRecognizer(ges)
        return maskView
    }()
    
    /** 即将布局转场的子视图 */
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        switch presentingVCType {
        case .BaseVC?:
            // presentedView 被展现的控制器视图
            // containerView 容器视图
//            presentedView?.frame = CGRect(x: 0, y: 0, width: kNXProfileVCViewW, height: kScreenH)
//            // 添加蒙版
//            maskView.frame = UIScreen.main.bounds
            presentedView?.frame = UIScreen.main.bounds
        case .ProfileVC?:
            presentedView?.frame = UIScreen.main.bounds
        default:
            break
        }
        
    }
    
}

extension NXProfilePresentationer {
    @objc fileprivate func dismiss() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}

extension NXProfilePresentationer {
    
    /** 动画执行周期方法(系统自动调) */
    open override func presentationTransitionWillBegin() {
    }
    
    open override func presentationTransitionDidEnd(_ completed: Bool) {
    }
    
    open override func dismissalTransitionWillBegin() {
    }
    
    open override func dismissalTransitionDidEnd(_ completed: Bool) {
    }
    
}








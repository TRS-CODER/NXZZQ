//
//  NXProfileAnimator.swift
//  中国·宁夏
//
//  Created by yudai on 2017/11/30.
//  Copyright © 2017年 拓尔思. All rights reserved.
//

import UIKit

private let kNXProfileVCViewW: CGFloat = kInch58() ? kScreenW * 0.815 : kScreenH * 900 / 1920

enum AnimationType {
    case profile           // 个人中心
    case collection        // 个人中心下属我的收藏
}

class NXProfileAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    /** 当前是否在进行展示动画 */
    open var isPresenting = false
    
    /** 发起转场动画的View */
    open var presentingView: UIView?
    
    /** 转场动画类型 */
    fileprivate var animationType: AnimationType?
    
    init(animationType: AnimationType) {
        super.init()
        self.animationType = animationType
    }
}

extension NXProfileAnimator {
    
    /// 依据动画上下文返回一个动画执行的时间
    ///
    /// - Parameter transitionContext: 转场动画上下文
    /// - Returns: 转场动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    /// 告诉系统如何动画，不管是展现还是消失都会进这个方法
    ///
    /// - Parameter transitionContext: 包含动画所需要的所有参数
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch animationType {
        case .profile?:
            profileAnimating(using: transitionContext)
        case .collection?:
            collectionAnimating(using: transitionContext)
        case .none:
            break
        }
    }
    
    /** 个人中心动画效果 */
    fileprivate func profileAnimating(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            //1. 拿到展现视图
            let toView = transitionContext.view(forKey: .to)
            //2. 添加视图到容器
            transitionContext.containerView.addSubview(toView!)
            //3. 设置展示视图的transform
            toView?.transform = CGAffineTransform(translationX: -kScreenW, y: 0)
            toView?.frame = UIScreen.main.bounds
            transitionContext.containerView.frame = UIScreen.main.bounds
            //4. 执行动画
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { [weak self] in
                toView?.transform = .identity
                toView?.frame = UIScreen.main.bounds
                transitionContext.containerView.frame = UIScreen.main.bounds
                self?.presentingView?.frame.origin.x = 0
            }) { (_) in
                // 4.1 动画完毕告诉系统动画结束
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        } else {
            // 4.2 执行关闭动画
            let fromView = transitionContext.view(forKey: .from)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { [weak self] in
                fromView?.transform = CGAffineTransform(translationX: -kNXProfileVCViewW, y: 0)
                self?.presentingView?.frame.origin.x = 0
                }, completion: { (_) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
    
    /** 个人收藏动画效果 */
    fileprivate func collectionAnimating(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            //1. 拿到展现视图
            let toView = transitionContext.view(forKey: .to)
            //2. 设置展示视图的transform
            toView?.transform = CGAffineTransform(translationX: kScreenW, y: 0)
            //3. 添加视图到容器
            transitionContext.containerView.addSubview(toView!)
            //4. 执行动画
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { [weak self] in
                toView?.transform = .identity
                self?.presentingView?.frame.origin.x = 0
            }) { (_) in
                // 4.1 动画完毕告诉系统动画结束
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        } else {
            // 4.2 执行关闭动画
            let fromView = transitionContext.view(forKey: .from)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { [weak self] in
                fromView?.transform = CGAffineTransform(translationX: kScreenW, y: 0)
                self?.presentingView?.frame.origin.x = 0
                }, completion: { (_) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}










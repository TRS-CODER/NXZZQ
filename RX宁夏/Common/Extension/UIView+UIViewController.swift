//
//  UIView+UIViewController.swift
//  ENJOY
//
//  Created by yudai on 2018/1/10.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 让参数view 一个绕着z 轴无限旋转
    class func creatRotationAnimation(view : UIView) {
        let rotateAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnim.fromValue = 0
        rotateAnim.toValue = Double.pi * 2
        rotateAnim.duration = 40
        rotateAnim.repeatCount = MAXFLOAT
        rotateAnim.isRemovedOnCompletion = false
        view.layer.add(rotateAnim, forKey: "rotation")
    }
    
    /// 移除参数view 的旋转动画
    open class func removeRotationAnimation(view : UIView) {
        view.layer.removeAnimation(forKey: "rotation")
    }
    
    /// 让参数view 暂停旋转
    class func pauseRotationAnimation(view : UIView) {
        let pausedTime = view.layer.convertTime(CACurrentMediaTime(), from: nil)
        view.layer.speed = 0.0
        view.layer.timeOffset = pausedTime
    }
    
    /// 让参数view 恢复旋转
    class func resumeRotationAnimation(view : UIView) {
        let pausedTime = view.layer.timeOffset
        view.layer.speed = 1.0
        view.layer.timeOffset = 0.0
        view.layer.beginTime = 0.0
        let timeSincePause = view.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        view.layer.beginTime = timeSincePause
    }
    
    /// 给一个View添加模糊效果蒙版
    ///
    /// - Parameter blurEffectStyle: 模糊效果类型
    public func addBlurEffect(blurEffectStyle: UIBlurEffectStyle) {
        let blurEffect = UIBlurEffect(style: blurEffectStyle)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame.size = CGSize(width: self.frame.width, height: self.frame.height)
        addSubview(blurView)
    }
    
}

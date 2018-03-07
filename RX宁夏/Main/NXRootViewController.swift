//
//  NXRootViewController.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/11.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit
import SnapKit

// MARK:- 常量
fileprivate struct Metric {
    static let profileVCViewW : CGFloat = kInch58() ? kScreenW * 0.815 : kScreenH * 900 / 1920
}

class NXRootViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: view.bounds)
        sv.contentSize = CGSize(width: kScreenW + Metric.profileVCViewW, height: 0)
        sv.bounces = false
        sv.isScrollEnabled = false
        sv.delegate = self
        sv.addSubview(mainTabVC.view)
        sv.addSubview(profileVC.view)
        sv.addSubview(maskView)
        sv.contentOffset = CGPoint(x: Metric.profileVCViewW, y: 0)
        sv.backgroundColor = UIColor.white
        return sv
    }()
    
    private lazy var profileVC: NXProfileController = {
        let pvc = NXProfileController()
        pvc.view.frame = CGRect(x: 0, y: 0, width: Metric.profileVCViewW, height: kScreenH)
        return pvc
    }()
    
    private lazy var mainTabVC: NXMainTabBarController = {
        let mvc = NXMainTabBarController()
        mvc.view.frame = CGRect(x: Metric.profileVCViewW, y: 0, width: kScreenW, height: kScreenH)
        return mvc
    }()
    
    private lazy var maskView: UIView = {
        let mv = UIView(frame: CGRect(x: Metric.profileVCViewW, y: 0, width: kScreenW, height: kScreenH))
        mv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideProfile)))
//        let swipeGes = UISwipeGestureRecognizer(target: self, action: #selector(hideProfile))
        // 清扫手势加了效果不是很好(后续看有什么更好的解决方案没)
//        swipeGes.direction = .left
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(panMaskView(ges:)))
        mv.addGestureRecognizer(panGes)
//        mv.addGestureRecognizer(swipeGes)
        /** 调整手势优先级 */
//        panGes.require(toFail: swipeGes)
        mv.backgroundColor = UIColor.black
        mv.alpha = 0
        return mv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initEvent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 避免动画效果不好看
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) { [weak self] in
            self?.hideProfile()
        }
    }
    
}

extension NXRootViewController {
    private func initUI() {
        /** 修复scrollView下移BUG */
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        view.addSubview(scrollView)
        
        addChildViewController(mainTabVC)
        addChildViewController(profileVC)
    }
    
    private func initEvent() {
        mainTabVC.edgePanBlock = { [weak self] (ges) in
            self?.panMaskView(ges: ges)
        }
        
        mainTabVC.profileClickedBlock = { [weak self] in
            self?.showProfile()
        }
    }
    
    @objc private func panMaskView(ges: UIPanGestureRecognizer) {
        let offset = ges.location(in: view).x
        guard offset <= Metric.profileVCViewW else { return }
        if ges.state == .changed {
            scrollView.setContentOffset(CGPoint(x: Metric.profileVCViewW-offset, y: 0), animated: false)
            maskView.alpha = offset/Metric.profileVCViewW * 0.4
        } else if ges.state == .ended {
            hanldProfile(offset: offset)
        }
    }
}

extension NXRootViewController {
    private func hanldProfile(offset: CGFloat) {
        if offset > kScreenW*0.33 {
            showProfile()
        } else {
            hideProfile()
        }
    }
    
    @objc private func showProfile() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.scrollView.setContentOffset(CGPoint.zero, animated: true)
            self?.maskView.alpha = 0.4
        })
    }
    
    @objc private func hideProfile() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.scrollView.setContentOffset(CGPoint(x: Metric.profileVCViewW, y: 0), animated: true)
            self?.maskView.alpha = 0
        }
    }
}

extension NXRootViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        profileVC.handleEffect(offset: scrollView.contentOffset.x)
    }
}










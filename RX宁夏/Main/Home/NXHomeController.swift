//
//  NXHomeController.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/5.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit
import TYPagerController
import SnapKit
import Moya
import RxSwift
import RxCocoa
import NSObject_Rx
import SwiftyJSON

// MARK:- 常量
fileprivate struct Metric {
    static let pagerBarFontSize = UIFont.systemFont(ofSize: 17.0)
    static let pagerBarSelectedFontSize = UIFont.systemFont(ofSize: 21.0)
    static let pagerBarHeight: CGFloat = 38.0
}

class NXHomeController: UIViewController {
    
    open var edgePanBlock: ((UIScreenEdgePanGestureRecognizer) -> Void)?
    
    private var dataSource: [NXHomeModel]?
    
    private var prodiver = MoyaProvider<API>()
    
    private lazy var pageVC: TYTabPagerController = {
        let pv = TYTabPagerController()
        pv.tabBarHeight = Metric.pagerBarHeight
        pv.dataSource = self
        pv.delegate = self

        pv.tabBar.layout.cellWidth = kScreenW * 0.2
        pv.tabBar.layout.cellSpacing = 0
        pv.tabBar.layout.cellEdging = 0
        pv.tabBar.layout.normalTextFont = Metric.pagerBarFontSize
        pv.tabBar.layout.selectedTextFont = Metric.pagerBarSelectedFontSize
        pv.tabBar.layout.progressColor = kBlueC
        pv.tabBar.layout.selectedTextColor = kBlueC

        return pv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initEvent()
        requestHomeData()
    }
    
}

extension NXHomeController {
    
    private func initUI() {
        // Point 之前是removeFromSuperView移除导致pop回来frame不对........
//        navigationController?.navigationBar.removeFromSuperview() = true
        
        addChildViewController(pageVC)
        view.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(kNavBarH())
            make.bottom.equalTo(-kTabBarH())
        }
    }

    private func initEvent() {
        pageVC.edgePanBlock = { [weak self] (ges) in
            self?.edgePanBlock?(ges)
        }
    }
    
    private func requestHomeData() {
        prodiver.rx.request(.home).mapJSON().asObservable().yd_json { return JSON($0)["response"] }.mapArray(NXHomeModel.self).subscribe(onNext: { [weak self] (dataSource) in
            self?.dataSource = dataSource
            self?.pageVC.reloadData()
        }, onError: { (err) in
            print(err)
        }).disposed(by: rx.disposeBag)
    }
}

extension NXHomeController: TYTabPagerControllerDelegate, TYTabPagerControllerDataSource {
 
    func numberOfControllersInTabPagerController() -> Int {
        return dataSource?.count ?? 0
    }
    
    func tabPagerController(_ tabPagerController: TYTabPagerController, controllerFor index: Int, prefetching: Bool) -> UIViewController {
        let VC = NXCommonTable(api: dataSource![index].channelUrl)
        return VC
    }
    
    func tabPagerController(_ tabPagerController: TYTabPagerController, titleFor index: Int) -> String {
        return dataSource![index].channelTitle
    }
}











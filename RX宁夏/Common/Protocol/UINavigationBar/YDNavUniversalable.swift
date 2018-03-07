//
//  YDNavUniversalable.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/6.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SnapKit
import RxGesture

// MARK:- 常量
fileprivate struct Metric {
    static let btnWH: CGFloat = 30.0
    static let logoViewRatio: CGFloat = 689/70
}

protocol YDNavUniversalable {
    
}

// MARK:- 导航栏 通用组件
struct YDNavigationBarItemMetric {
    
    // 左边
    static let back = YDNavigationBarItemModel(type: .back,
                                               position: .left,
                                               description: "返回",
                                               imageNamed: "nav_back")
    
    static let profile = YDNavigationBarItemModel(type: .profile,
                                                  position: .left,
                                                  description: "个人中心",
                                                  imageNamed: "nav_profile")
    
    // 右边
    static let search = YDNavigationBarItemModel(type: .search,
                                                position: .right,
                                                description: "搜索",
                                                imageNamed: "nav_search")
    
    static let font = YDNavigationBarItemModel(type: .font,
                                                 position: .right,
                                                 description: "字体",
                                                 imageNamed: "nav_font")
    
    // 中间
    static let logo = YDNavigationBarItemModel(type: .logo,
                                               position: .center,
                                               description: "logo",
                                               imageNamed: "nav_logo")
}

// MARK:- 添加到视图的组件，需要自己主动设置位置
extension YDNavUniversalable where Self: UIView {
    
    // MARK:- 导航栏 通用组件(不支持点击事件回传)
    func universal(model: YDNavigationBarItemModel) -> UIView {
        switch model.description {
        case "logo":
            let view = UIView()
            view.backgroundColor = UIColor.clear
            
            let imageView = UIImageView(image: UIImage(named: model.imageNamed))
            
            view.addSubview(imageView)
            self.addSubview(view)
            
            view.snp.makeConstraints({ (make) in
                make.height.equalTo(25)
                make.width.equalTo(view.snp.height).multipliedBy(Metric.logoViewRatio)
            })
            
            imageView.snp.makeConstraints({ (make) in
                make.left.right.bottom.top.equalToSuperview()
            })
            return view
        default:
            return UIView()
        }
    }
    
    // MARK:- 导航栏 通用组件(支持点击事件回传)
    func universal(model: YDNavigationBarItemModel, onNext: @escaping (_ model: YDNavigationBarItemModel)->Void) -> UIView {
        
        // 创建组件
        let view = UIView()
        view.backgroundColor = .clear
        
        let btn = UIButton()
        // 设置属性
        btn.contentMode = .scaleAspectFit
        btn.setTitle(model.title, for: .normal)
        btn.setBackgroundImage(UIImage(named: model.imageNamed), for: .normal)
        // 处理点击事件
        btn.rx.tapGesture().when(.recognized)
            .subscribe({ _ in
                onNext(model)
            }).disposed(by: rx.disposeBag)
        
        // 添加组件
        view.addSubview(btn)
        
        self.addSubview(view)
        
        // 添加约束
        // 此处必须指定一个大小
        view.snp.makeConstraints { (make) in
            make.width.height.equalTo(Metric.btnWH)
        }
        
        btn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        return view
    }
}

// MARK:- 导航栏 通用组件 数据模型
struct YDNavigationBarItemModel {
    
    enum YDNavigationBarItemPosition {
        case left
        case center
        case right
    }
    
    enum YDNavigationBarItemType {
        case back
        case share
        case more
        case profile
        case title(index: Int, title: String)
        case message
        case history
        case download
        case search
        case setting
        case logo
        case font
    }
    
    var type: YDNavigationBarItemType
    var position: YDNavigationBarItemPosition
    var title: String?
    var description: String
    var imageNamed: String
    var highlightedImageNamed: String
    
    init(type: YDNavigationBarItemType, position: YDNavigationBarItemPosition, title: String, description: String) {
        
        self.type = type
        self.position = position
        self.title = title
        self.description = description
        self.imageNamed = ""
        self.highlightedImageNamed = ""
    }
    
    init(type: YDNavigationBarItemType, position: YDNavigationBarItemPosition, description: String, imageNamed: String) {
        
        self.type = type
        self.position = position
        self.title = nil
        self.description = description
        self.imageNamed = imageNamed
        self.highlightedImageNamed = ""
    }
    
    init(type: YDNavigationBarItemType, position: YDNavigationBarItemPosition, description: String, imageNamed: String, highlightedImageNamed: String) {
        
        self.type = type
        self.position = position
        self.title = nil
        self.description = description
        self.imageNamed = imageNamed
        self.highlightedImageNamed = highlightedImageNamed
    }
}

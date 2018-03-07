//
//  NXProfileController.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/5.
//  Copyright © 2018年 拓尔思. All rights reserved.
//  支持视差效果滚动(仿QQ)

import UIKit
import ObjectMapper
import Moya

struct NXProfileModel: Mappable {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        about <- map["aboutLink"]
        recoment <- map["recomentLink"]
        web <- map["webLink"]
        wechat <- map["wechatLink"]
        weibo <- map["weiboLink"]
    }
    
    var about: String?
    var recoment: String?
    var web: String?
    var wechat: String?
    var weibo: String?
}

class NXProfileController: UIViewController {
    
    private let provider = MoyaProvider<API>()
    
    private var dataSource: NXProfileModel?
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        // 避免手动滑动
        sv.isScrollEnabled = false
        return sv
    }()
    
    private lazy var bgImage: UIImageView = {
        let bi = UIImageView(image: UIImage(named: "profile_bg"))
        return bi
    }()
    
    private lazy var logoView: UIImageView = {
        let lv = UIImageView(image: UIImage(named: "profile_logo"))
        return lv
    }()
    
    private let profileListData = ["我的收藏","推荐给好友","设置","关于我们"]
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .plain)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = UIColor.clear
        tv.separatorStyle = .none
        tv.isScrollEnabled = false
        tv.rowHeight = NXProfileCellH
        return tv
    }()
    
    private let thirdpartyDatas: [[String : String]] = [
        ["title": "网站", "image": "profile_website"],
        ["title": "微信", "image": "profile_wechat"],
        ["title": "微博", "image": "profile_weibo"]
    ]
    
    private var thirdpartyBtns = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        requestData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // 背景
        scrollView.frame = view.bounds
        bgImage.frame = scrollView.bounds

        // 上
        let logoViewW: CGFloat = view.bounds.width - 60
        logoView.frame = CGRect(x: 30, y: 40, width: logoViewW, height: logoViewW/714*195)
        
        // 中
        let tableViewTopMargin : CGFloat = kInch58() ? 60 : kInch55() ? 50 : kInch47() ? 40 : 25
        tableView.frame = CGRect(x: 30, y: logoView.frame.maxY + tableViewTopMargin, width: view.bounds.width - 2 * 30, height: NXProfileCellH * CGFloat(profileListData.count))
        
        // 下
        let btnW: CGFloat = (view.bounds.width - 40)/3
        let btnH: CGFloat = btnW/2
        let btnY: CGFloat = view.bounds.height - btnH - 50
        for (i,btn) in thirdpartyBtns.enumerated() {
            btn.frame = CGRect(x: 20 + CGFloat(i)*btnW, y: btnY, width: btnW, height: btnH)
        }
    }
    
    @objc func test() {
//        print("2222")
    }
    
}

extension NXProfileController {
    private func initUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(bgImage)
        scrollView.addSubview(logoView)
        scrollView.addSubview(tableView)
        
        thirdpartyDatas.forEach {
            let btn = UIButton(img: $0["image"]!, title: $0["title"]!, fontSize: 15)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0)
            btn.addTarget(self, action: #selector(test), for: .touchUpInside)
            thirdpartyBtns.append(btn)
            scrollView.addSubview(btn)
        }
    }
    
    private func requestData() {
        provider.rx.request(.profile).mapJSON().asObservable().mapObject(NXProfileModel.self).subscribe(onNext: { [weak self] (dataSource) in
            self?.dataSource = dataSource
        }).disposed(by: rx.disposeBag)
    }
    
    /// 视差效果
    open func handleEffect(offset: CGFloat) {
        let minusX = view.frame.origin.x - offset
        let imageOffsetX = minusX*0.4
        scrollView.contentOffset = CGPoint(x: imageOffsetX, y: 0)
    }
}

extension NXProfileController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NXProfileCell.tableViewCell(tableView: tableView)
        cell.title = profileListData[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch profileListData[indexPath.row] {
        case "设置":
            let destVC = ZYSettingViewController()
            navigationController?.pushViewController(destVC, animated: true)
        default:
            print(indexPath)
        }
    }
    
}






























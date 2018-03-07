//
//  ZYSettingViewController.swift
//  掌上遂宁
//
//  Created by 张宇 on 2016/10/20.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit
import MBProgressHUD
import Kingfisher
import SnapKit

class ZYSettingViewController: UIViewController {

    private lazy var tableView : UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = 48
        tv.backgroundColor = kBGC
        tv.separatorStyle = .none
        tv.register(UINib.init(nibName: "ZYSettingCell", bundle: nil), forCellReuseIdentifier: "ZYSettingCell")
        return tv
    }()
    
    private lazy var dataSource: [[[String : String]]] = {
        var ds = [[[String : String]]]()
        let path = Bundle.main.path(forResource: "Setting", ofType: "plist")
        ds = NSArray.init(contentsOfFile: path!) as! [[[String : String]]]
        return ds
    }()
    
    private let navBar = NXSettingNavBar()
    
    private lazy var changeFontView : SNSettingWebFontView = {
        let changeFontView = SNSettingWebFontView.creatFontView()
        return changeFontView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        // iOS11适配
        if #available(iOS 11.0, *) { tableView.contentInsetAdjustmentBehavior = .never }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.viewNeedUpdate), name: NSNotification.Name.UIApplicationWillEnterForeground, object: self)
    }
    
    @objc private func viewNeedUpdate() {
        tableView.reloadData()
    }
}

extension ZYSettingViewController {
    
    private func initUI() {
        view.addSubview(navBar)
        view.addSubview(tableView)
        
        navBar.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(kScreenW)
            make.height.equalTo(kNavBarH())
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension ZYSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZYSettingCell") as! ZYSettingCell
        cell.dict = dataSource[indexPath.section][indexPath.row]
        cell.options = ({[weak self] ( cellOption : ZYSettingCellOption, dict : [String : String], Switch : UISwitch?) -> () in
            self!.hanldCellOptionEvent(cellOption, dict, Switch)
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 10))
        header.backgroundColor = kBGC
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // 仅仅用来调间距
    }

}

// MARK: - cell的操作回调处理
extension ZYSettingViewController {
    private func hanldCellOptionEvent(_ cellOption: ZYSettingCellOption, _ dict : [String : String], _ Switch : UISwitch?) {
        switch cellOption {
        case .push:
            break
//            let destVC = NSObject.ZYGetClassWithNamespace(dict["destClass"]!)
//            self.navigationController?.pushViewController(destVC!, animated: true)
        case .canReceiveNote:
            // 通知状态用户要修改，开或者关都需要用户去系统里面进行设置，这里只做跳转，在回调以后进行设置，刷新通知的状态
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
        case .clearMemery:
            // 计算当前的缓存大小，如果没有缓存，不再执行清理工作
            KingfisherManager.shared.cache.calculateDiskCacheSize(completion: { [weak self] (size : UInt) in
                if size == 0 {
                    let hud = MBProgressHUD.showAdded(to: (self?.view)!, animated: true)
                    hud.mode = .text
                    hud.label.text = "没有缓存数据"
                    hud.backgroundView.style = .solidColor
                    hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
                    hud.hide(animated: true, afterDelay: 1)
                } else {
                    let hud = MBProgressHUD.showAdded(to: (self?.view)!, animated: true)
                    hud.label.text = "正在清除..."
                    hud.backgroundView.style = .solidColor
                    hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
                    KingfisherManager.shared.cache.clearDiskCache(completion: {
                        self?.tableView.reloadData()
                        hud.hide(animated: true, afterDelay: 0.5)
                        hud.label.text = "清除完毕"
                    })
                }
            })
        case .onlyWiFiLoad:
            let bool = UserDefaults.standard.bool(forKey: kIsLoadOnWIFI)
            Switch?.setOn(!bool, animated: true)
            UserDefaults.standard.set(!bool, forKey: kIsLoadOnWIFI)
            UserDefaults.standard.synchronize()
        case .setFontSize:
            // 弹出字体控制控件
            changeFontView.show()
            changeFontView.fontDidChangeClosure = ({ [weak self] (_)  in
                // 刷新cell
                self?.tableView.reloadData()
            })
            break
        default:
            break
        }
    }
}

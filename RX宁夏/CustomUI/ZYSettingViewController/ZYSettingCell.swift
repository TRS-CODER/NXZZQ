//
//  ZYSettingCell.swift
//  掌上遂宁
//
//  Created by 张宇 on 2016/11/1.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit
import Kingfisher

enum ZYSettingCellType : String {
    case Arrow          = "0"
    case Switch         = "1"
    case Label          = "2"
    case LabelArrow     = "3"
}

enum ZYSettingCellOption : String {
    case push           = "push"
    case setFontSize    = "setFontSize"
    case canReceiveNote = "canReceiveNote"
    case clearMemery    = "clearMemery"
    case onlyWiFiLoad   = "onlyWiFiLoad"
    case nightMode      = "nightMode"
}

typealias clickOption = (_ cellOption : ZYSettingCellOption, _ dict : [String : String], _ Switch: UISwitch?) -> Void

class ZYSettingCell: UITableViewCell {
    
    /** 数据字典 */
    open var dict : [String : String]? {
        didSet {
            updateCell()
        }
    }
    
    /** cell的点击操作 */
    open var options : clickOption?
    
    @IBOutlet weak var titleW: NSLayoutConstraint!
    @IBOutlet weak var subTitleW: NSLayoutConstraint!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var arrowView: UIImageView!
    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet weak var cutLine1: UIView!
    @IBOutlet weak var cutLine2: UIView!
    
    /** cell的布局类型 */
    fileprivate var cellType = ZYSettingCellType.Arrow
    /** cell的默认操作 */
    fileprivate var cellOption = ZYSettingCellOption.push
    
    fileprivate func updateCell() {
        
        title.text = dict!["title"]
        subTitle.text = dict!["subTitle"]
        cellType = ZYSettingCellType(rawValue:dict!["cellType"]!)!
        cellOption = ZYSettingCellOption(rawValue: dict!["optionType"]!)!
        iconView.isHidden = dict!["icon"] == "" ? true : false
        titleW.constant = dict!["icon"] == "" ? 10 : 55
        if dict!["icon"] != "" {
            iconView.image = UIImage(named: dict!["icon"]!)
        }
        switch cellType {           // 设置cell的样式
        case .Arrow:
            Switch.isHidden = true
            arrowView.isHidden = false
        case .Switch:
            Switch.isHidden = false
            arrowView.isHidden = true
            Switch.addTarget(self, action: #selector(self.handleSwitch(Switch:)), for: .valueChanged)
        case .Label:
            Switch.isHidden = true
            arrowView.isHidden = true
        case .LabelArrow:
            Switch.isHidden = true
            arrowView.isHidden = false
        }
        
        switch cellOption {         // 设置cell的一些数据
        case .setFontSize:
            let fontSize = UserDefaults.standard.float(forKey: kFontSize)
            var fontStr = ""
            switch fontSize {
            case 0:
                fontStr = "极小"
            case 1:
                fontStr = "小"
            case 2:
                fontStr = "中"
            case 3:
                fontStr = "大"
            case 4:
                fontStr = "极大"
            default:
                break
            }
            subTitle.text = fontStr
        case .canReceiveNote:
            // 查看用户是否已经同意了远程通知
//            let isOn = UIApplication.shared.currentUserNotificationSettings?.types.contains(UIUserNotificationType.alert) ?? false
//            Switch.setOn(isOn, animated: true)
            break
        case .onlyWiFiLoad:
            Switch.setOn(UserDefaults.standard.bool(forKey: kIsLoadOnWIFI), animated: false)
        case .push:
            break
        case .clearMemery:
            if self.subTitle.text == "" {
                KingfisherManager.shared.cache.calculateDiskCacheSize(completion: { (size : UInt) in
                    let cacheSize = CGFloat(size)/1024.0/1024.0
                    self.subTitle.text = "\(String(format: "%.2f", cacheSize))M"
                })
            }
        default:
            break
        }
    }
    
    @objc private func handleSwitch(Switch : UISwitch) {
        // 此项目开关有两种，一种是WIFI加载 一种是接收通知
        if self.options != nil {                               // 回调传值
            self.options!(cellOption, dict!, Switch)
        }
    }
    
    @IBAction func cellDidClick(_ sender: UIButton) {
        if self.options != nil && cellType != .Switch {        // 回调传值  Switch的单独回调
            self.options!(cellOption, dict!, nil)
        }
    }
    
}

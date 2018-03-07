//
//  SNSettingWebFontView.swift
//  掌上遂宁
//
//  Created by 张宇 on 2016/11/2.
//  Copyright © 2016年 张宇. All rights reserved.
//

import UIKit

class SNSettingWebFontView: UIView {
    
    public var fontDidChangeClosure : ((_ value : CGFloat) -> Void)?
    
    open func show() {
        let keywindow = UIApplication.shared.keyWindow
        keywindow?.addSubview(self)
        UIView.animate(withDuration: 0.3) {
            self.distanceH.constant = kScreenH - 200 - (kInch58() ? 34 : 0)
            self.controlView.frame = CGRect(x: 0, y: kScreenH - 200 - (kInch58() ? 34 : 0), width: kScreenW, height: 200)
        }
    }
    
    /** 初始化方法 */
    class open func creatFontView() -> SNSettingWebFontView {
        return Bundle.main.loadNibNamed("SNSettingWebFontView", owner: nil, options: nil)?.first as! SNSettingWebFontView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame = UIScreen.main.bounds
        self.distanceH.constant = UIScreen.main.bounds.height
        self.controlView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 200)
        fontSlider.isContinuous = false
        
        // 绑定点击事件
        let tap  = UITapGestureRecognizer(target: self, action: #selector(self.sliderDidTap(tap:)))
        fontSlider.addGestureRecognizer(tap)
        // 设置格数
        fontSlider.minimumValue = 0
        fontSlider.maximumValue = 4
        let fontSize = UserDefaults.standard.float(forKey: kFontSize)
        fontSlider.setValue(fontSize, animated: false)
    }
    @IBOutlet weak var controlView: UIView!
    
    @IBOutlet weak var distanceH: NSLayoutConstraint!
    
    @IBOutlet weak var fontSlider: UISlider!
    
    @IBAction func cancelButtonClick(_ sender: UIButton) {
        hide()
    }
    
    @IBAction func fontSliderValueChanged(_ sender: UISlider) {
        sender.setValue(nearbyintf(sender.value), animated: true)
        UserDefaults.standard.set(nearbyintf(sender.value), forKey: kFontSize)
        UserDefaults.standard.synchronize()
        if self.fontDidChangeClosure != nil {
            self.fontDidChangeClosure!(CGFloat(nearbyintf(sender.value)))
        }
    }
    
    @objc private func sliderDidTap(tap : UITapGestureRecognizer) {
        let slider = tap.view as! UISlider
        let value = CGFloat((slider.maximumValue - slider.minimumValue)) * tap.location(in: slider).x / slider.frame.width
        slider.setValue(nearbyintf(Float(value)), animated: true)
        
        UserDefaults.standard.set(nearbyintf(Float(value)), forKey: kFontSize)
        UserDefaults.standard.synchronize()
        
        if self.fontDidChangeClosure != nil {
            self.fontDidChangeClosure!(CGFloat(nearbyintf(Float(value))))
        }
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.distanceH.constant = UIScreen.main.bounds.height
            self.controlView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 200)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}

//
//  UIWidget+Extension.swift
//  ENJOY
//
//  Created by yudai on 2018/1/10.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

// MARK: - UILabel Extensions
extension UILabel {
    
    /// 遍历构造函数扩充1
    ///
    /// - Parameters:
    ///   - frame: label的frame
    ///   - title: lable的文字
    ///   - color: label的字体颜色
    ///   - fontSize: label的字体
    convenience init(_ frame: CGRect, _ title: String, _ color: UIColor, _ fontSize: CGFloat) {
        self.init()
        self.frame = frame
        text = title
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
    }
    
    /// 根据字符串 获取lable的宽度
    ///
    /// - Parameters:
    ///   - labelStr: 需要计算宽度的NSString
    ///   - font: label的字体大小
    ///   - height: label指定的最大高度
    /// - Returns: label的宽度
    class func getLabelWidth(_ labelStr: String,_ fontSize: CGFloat,_ height: CGFloat) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize(width: 999, height: height)
        let font = UIFont.systemFont(ofSize: fontSize)
        let dict = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dict as? [NSAttributedStringKey : Any], context: nil).size
        return strSize.width
    }
    
    /// 根据字符串 获取lable的高度
    ///
    /// - Parameters:
    ///   - labelStr: 需要计算高度的NSString
    ///   - font: label的字体大小
    ///   - width: label的指定最大宽度
    /// - Returns: lable的高度
    class func getLabelHeight(_ labelStr: String, _ fontSize: CGFloat, _ width: CGFloat) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize(width: width, height: 999)
        let font = UIFont.systemFont(ofSize: fontSize)
        let dict = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dict as? [NSAttributedStringKey : Any], context: nil).size
        return strSize.height
    }
    
    /// 限定最多行数返回高度
    ///
    /// - Parameters:
    ///   - labelStr: 需要计算高度的NSString
    ///   - font: label的字体大小
    ///   - width: label的宽度
    ///   - maxRows: 标签最大行数(默认Int.max)
    /// - Returns: lable的高度
    class func getLabelHeight(_ labelStr: String, _ fontSize: CGFloat, _ width: CGFloat, _ maxRows: Int = Int.max) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let font = UIFont.systemFont(ofSize: fontSize)
        let dict = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dict as? [NSAttributedStringKey : Any], context: nil).size
        let maxH = UILabel.getLabelHeight("1", fontSize, width) * CGFloat(maxRows)
        return min(strSize.height, maxH)
    }
}

// MARK: - UIButton Extensions
extension UIButton {
    
    /// 便利构造函数扩充1
    ///
    /// - Parameters:
    ///   - title: 按钮的文字
    ///   - titleColor: 按钮的颜色
    ///   - fontSize: 按钮文字的字体
    convenience init(title : String, titleColor : UIColor, fontSize : CGFloat) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    /// 便利构造函数扩充2
    ///
    /// - Parameters:
    ///   - title: 按钮的文字
    ///   - norColor: 普通状态的文字颜色
    ///   - selColr: 选中状态的文字颜色
    ///   - bgColor: 按钮的背景颜色
    ///   - fontSize: 按钮文字的字体
    convenience init(title : String, norColor : UIColor, selColr: UIColor, bgColor : UIColor, fontSize : CGFloat) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(norColor, for: .normal)
        setTitleColor(selColr, for: .selected)
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    /// 便利构造函数扩充3
    ///
    /// - Parameters:
    ///   - norImage: 按钮普通状态的图片
    ///   - selImage: 按钮选中状态的图片
    convenience init(norImage: String, selImage:String) {
        self.init()
        setImage(UIImage(named:norImage), for: .normal)
        setImage(UIImage(named:selImage), for: .selected)
    }
    
    /// 遍历构造函数扩充4
    ///
    /// - Parameters:
    ///   - img: 普通状态图片
    ///   - title: 标题
    ///   - fontSize: 字体大小
    convenience init(img : String, title : String , fontSize : CGFloat) {
        self.init()
        setImage(UIImage(named:img), for: .normal)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
    }
    
}

// MARK: UIFont Extensions
extension UIFont {
    
    /// 获得某个字体的高度
    ///
    /// - Parameter CGFloat: 字体大小
    /// - Returns: 对应高度
    class func getFontH(fontSize CGFloat: CGFloat) -> CGFloat {
        let statusLabelText: NSString = "" as NSString
        let size = CGSize(width: 1, height: 999)
        let font = UIFont.systemFont(ofSize: CGFloat)
        let dict = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dict as? [NSAttributedStringKey : Any], context: nil).size
        return strSize.height
    }
    
}









//
//  NSAttributeString+String.swift
//  ENJOY
//
//  Created by yudai on 2018/1/10.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    /// 前面带个小图标的富文本，图标大小先定死，以后再添加参数
    ///
    /// - Parameters:
    ///   - str: 需要设置的字符串
    ///   - image: 需要设置在前面的小图标
    /// - Returns: 带有前小图标的富文本
    public class func tagImageStr(with str: String,and image: UIImage) -> NSAttributedString? {
        // 定义富文本字符串
        let attributedStrM : NSMutableAttributedString = NSMutableAttributedString()
        
        // 字符串
        let str : NSAttributedString = NSAttributedString(string: " \(str)", attributes: nil)
        
        // 传入图片
        let image : UIImage = image
        let textAttachment : NSTextAttachment = NSTextAttachment()
        textAttachment.image = image
        textAttachment.bounds = CGRect(x: 0, y: -1, width: 30, height: 15)
        
        attributedStrM.append(NSAttributedString(attachment: textAttachment))
        attributedStrM.append(str)
        
        return attributedStrM
    }
    
  
}

extension String {

    /// 根据开始位置和长度截取字符串
    ///
    /// - Parameters:
    ///   - start: 起始位置
    ///   - length: 停止位置
    /// - Returns: 截取好的字符串
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    
    /// 给当前字符串添加删除线
    ///
    /// - Parameter lineColor: 删除线颜色
    /// - Returns: 添加删除线后的富文本
    func addDeletedLine(lineColor: UIColor) -> NSAttributedString? {
        let attributeString = NSMutableAttributedString(string: self, attributes:nil)
        attributeString.addAttribute(NSAttributedStringKey.baselineOffset, value: 0, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedStringKey.foregroundColor, value: lineColor, range: NSRange(location:0,length:attributeString.length))
        return attributeString
    }
    
    /// 将一个String某段做富文本(默认转化为红色字体)转换
    ///
    /// - Parameter rangeString: 需要变色的string
    /// - Parameter fontSize: 字体大小
    /// - Parameter color: 需要变的颜色(默认红色)
    /// - Parameter isBold: 是否加粗(默认不加粗)
    /// - Returns: 转换好的字符串
    public func changePartOfStringStyle(rangeString: String, fontSize: CGFloat, color: UIColor = UIColor.red, isBold: Bool = false) -> NSMutableAttributedString {
        let attriStr = NSMutableAttributedString(string:self)
        let range = NSMakeRange(NSString(string: self).range(of: rangeString).location, NSString(string: self).range(of: rangeString).length)
        attriStr.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        if isBold == true {
            attriStr.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "Helvetica-Bold", size: fontSize)!, range: range)
        }
        return attriStr
    }
    
    /// 将一个总共多少秒的时间 转换成 00:00:00 格式的字符串
    /// - parameter fromSecond: 时间长度（秒）
    static func format2TimeStr(_ fromSecond: Int) -> String {
        var timeStr = ""
        if fromSecond < 3600 {
            timeStr = String(format: "%02d:%02d", fromSecond / 60, fromSecond % 60)
        } else {
            timeStr = String(format: "%02d:%02d:02d", fromSecond / 3600, fromSecond / 3600 / 60, (fromSecond / 3600 / 60) % 60)
        }
        return timeStr
    }
    
    /// 将 YYYY-MM-dd HH:mm:ss 格式转换为 刚刚 几分钟前 等可描述的字符串 参数格式必须为 "yyyy-MM-dd hh:mm:ss"格式 否则返回为空
    ///
    /// - Parameter timeString: "yyyy-MM-dd hh:mm:ss"格式
    /// - Returns: 格式化后的String
    static func stringToDescription(_ timeString : String) -> String? {
        // 将传入的String 转换为 Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Beijing")
        let date = dateFormatter.date(from: timeString)
        if date == nil { return nil }
        // 拿到时间戳 进行分类处理
        let timeInterval = -date!.timeIntervalSinceNow
        if timeInterval < 60 {      // 60秒以内
            return "刚刚"
        } else if timeInterval/60 < 60 {        // 一个小时以内
            return "\(Int(timeInterval/60))" + "分钟前"
        } else if timeInterval/60/60 < 24 {     // 超过1小时 今天之内
            return "\(Int(timeInterval/60/60))" + "小时前"
        } else if timeInterval/60/60/24 < 1 {   // 今天
            return "今天"
        } else if timeInterval/60/60/24 < 2 {   // 昨天
            return "昨天"
        } else {    // 直接显示 年 月 日
            return (timeString as NSString).substring(to: 10)
        }
    }
    
    /// 将一个 Date 转换为 刚刚 几小时前  等描述性时间
    ///
    /// - Parameter date: Date 对象
    /// - Returns: "yyyy-MM-dd hh:mm:ss"格式String
    static func dateToDescription(_ date : Date) -> String {
        // 1.将Date 转换为 yyyy-MM-dd hh:mm:ss
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Beijing")
        let timeStr = dateFormatter.string(from: date)
        // 2.转换
        let str = stringToDescription(timeStr)
        return str!
    }
}












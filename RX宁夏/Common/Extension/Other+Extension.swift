//
//  Other+Extension.swift
//  ENJOY
//
//  Created by yudai on 2018/1/10.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

// MARK: - UIColor Extensions
extension UIColor {
    
    /// 简易的RGB获取UIColor的方法
    ///
    /// - parameter R:     0-255
    /// - parameter G:     0-255
    /// - parameter B:     0-255
    /// - parameter Alpha: 透明度
    ///
    /// - returns: UIColor
    convenience init(R Red:CGFloat, G:CGFloat, B:CGFloat, Alpha: CGFloat) {
        self.init(red: Red/255.0, green: G/255.0, blue: B/255.0, alpha: Alpha)
    }
    
    /// 获得一个随机颜色
    /// - Returns: UIColor
    class func randomColor() -> UIColor{
        return UIColor(R: CGFloat(arc4random_uniform(256)), G: CGFloat(arc4random_uniform(256)), B: CGFloat(arc4random_uniform(256)), Alpha: 1)
    }
    
}

// MARK: - CALayer Extensions
extension CALayer {
    /// 暂停动画
    func pauseAnimation() {
        let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
        self.speed = 0.0
        self.timeOffset = pausedTime
    }
    /// 恢复动画
    func resumeAnimation() {
        let pausedTime = timeOffset
        self.speed = 1.0
        self.timeOffset = 0.0
        self.beginTime = 0.0
        let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        self.beginTime = timeSincePause
    }
}

// MARK: - UIAlertController Extensions
extension UIAlertController {
    /// 弹出一个简单的alert
    class func addSingleAlert(_ title: String, _ message:String, _ actionTitle: String) {
        let sureAction = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(sureAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

extension Int {
    
    public func convert2DateString() -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        print(date)
        return ""
    }
}

// MARK: - Date Extensions
extension Date {
    
    /// 获取从1790年到当前时间秒数的字符串
    ///
    /// - Returns: 多少秒的字符串
    static func getTimeIntervalSince1970() -> String {
        let now = Date()
        return "\(now.timeIntervalSince1970)"
    }
    
    /// 获取从1970年到当前时间
    ///
    /// - Returns: 1970到现在一共多少秒
    static func getTimeIntervalSince1970() -> Int {
        let now = Date()
        return Int(now.timeIntervalSince1970)
    }
    
    /// Date 转 String
    /// - Returns: "yyyy-MM-dd hh:mm"的字符串
    static func getTimeString(from Date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        return dateFormatter.string(from: Date)
    }
    
    /// 2017-04-14 07:03:16 +0000 这种Date格式，转换为-> 刚刚  XX分钟前
    static func formatDate(date : Date) -> String {
        let nowDate = Date()
        let interval = nowDate.timeIntervalSince(date)      // 计算时间差
        if interval <= 60 {
            return "刚刚"
        }
        if interval <= 60 * 60 {
            return "\(Int(interval/60))分钟前"
        }
        // XX小时前
        if interval <= 60 * 60 * 24 {
            return "\(Int(interval / (60 * 60)))小时前"
        }
        // 创建日历对象
        let calendar = NSCalendar.current
        // 处理昨天数据: 昨天 12:23
        if calendar.isDateInYesterday(date) {
            let fmt = DateFormatter()
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: date)
            return timeStr
        }
        // 处理一年之内: 02-22 12:22
        let cmps = (calendar as NSCalendar).components(.year, from: date, to: nowDate as Date, options: [])
        if cmps.year! < 1 {
            let fmt = DateFormatter()
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: date)
            return timeStr
        }
        // 超过一年: 2014-02-12 13:22
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.string(from: date)
        return timeStr
    }
    
    /** 将新浪微博类似格式时间，转换成响应的字符串  Thu Dec 29 15:20:03 +0800 2016  -> 刚刚  XX分钟前 */
    static func formatSinaWeiBoDate(orgString : String) -> String {
        // 1.创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = NSLocale(localeIdentifier: "en") as Locale!
        // 2.将字符串时间,转成Date类型
        guard let createDate = fmt.date(from: orgString) else {
            return ""
        }
        // 3.创建当前时间
        let nowDate = NSDate()
        // 4.计算创建时间和当前时间的时间差
        let interval = Int(nowDate.timeIntervalSince(createDate))
        // 5.对时间间隔处理
        // 5.1.显示刚刚
        if interval <= 60 {
            return "刚刚"
        }
        // 5.2.59分钟前
        if interval <= 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        // 5.3.11小时前
        if interval <= 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        // 5.4.创建日历对象
        let calendar = NSCalendar.current
        // 5.5.处理昨天数据: 昨天 12:23
        if calendar.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        // 5.6.处理一年之内: 02-22 12:22
        let cmps = (calendar as NSCalendar).components(.year, from: createDate, to: nowDate as Date, options: [])
        if cmps.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        // 5.7.超过一年: 2014-02-12 13:22
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.string(from: createDate)
        return timeStr
    }
    
}

// MARK: URL Extension
extension URL {
    
    /// 检验一个作为URL的字符串是否合法
    ///
    /// - Parameter str: 需要校验的字符串
    /// - Returns: 检验结果
    public static func verifyUrl(str:String) -> Bool {
        //创建NSURL实例
        if let url = NSURL(string: str) {
            //检测应用是否能打开这个NSURL实例
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    
    /// 获得字符串里面的URL数组
    ///
    /// - Parameter str: 需要解析的字符串
    /// - Returns: 包含URL的数组
    public static func getUrls(str:String) -> [String] {
        var urls = [String]()
        // 创建一个正则表达式对象
        do {
            let dataDetector = try NSDataDetector(types:
                NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
            // 匹配字符串，返回结果集
            let res = dataDetector.matches(in: str,
                                           options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                           range: NSMakeRange(0, str.count))
            // 取出结果
            for checkingRes in res {
                urls.append((str as NSString).substring(with: checkingRes.range))
            }
        }
        catch {
            print(error)
        }
        return urls
    }
}

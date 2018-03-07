//
//  Common.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/5.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

// MARK: 尺寸相关

/** 全局间距 */
//let kMargin : CGFloat = 20
/** 全局常用宽度 */
//let kCommonW : CGFloat = UIScreen.main.bounds.width - 2 * kMargin

/** 全局sectionH */
let kSectionH : CGFloat = 40
/** 全局分割线高度 */
let kSeparateLineH : CGFloat = 0.5

/** 屏幕的宽度 */
let kScreenW  = UIScreen.main.bounds.width
/** 屏幕的高度 */
let kScreenH = UIScreen.main.bounds.height
/** 导航条的高度(适配iPhoneX) */
func kNavBarH() -> CGFloat {
    return kScreenH == 812.0 ? 88 : 64
}
/** tabBar高度 */
func kTabBarH() -> CGFloat {
    return kScreenH == 812.0 ? 83 : 49
}
/** 是否是3.5英寸屏 */
func kInch35() -> Bool {
    return UIScreen.main.bounds.height == 480.0
}
/** 是否是4.0英寸屏 */
func kInch40() -> Bool {
    return UIScreen.main.bounds.height == 568.0
}
/** 是否是4.7英寸屏 */
func kInch47() -> Bool {
    return UIScreen.main.bounds.height == 667.0
}
/** 是否是5.5英寸屏 */
func kInch55() -> Bool {
    return UIScreen.main.bounds.height == 736.0
}
/** 是否是5.8英寸屏 */
func kInch58() -> Bool {
    return UIScreen.main.bounds.height == 812.0
}

/********************** KEY ************************/
let kServerColumns          = "kServerColumns"          // 保存的服务器上次的频道信息 数组字典
let kUserColumnsTitles      = "kUserColumnsTitles"      // 保存用户本地的订阅频道信息 [String]
let kUserColumnsSpareTitles = "kUserColumnsSpareTitles" // 保存用户本地备用订阅信息 [String]
let kColumnFixCount         = "kColumnFixCount"         // 保存固定频道数 Int
let kKeepUserName           = "kKeepUserName"           // 记住用户名
let kUserSearchHistory      = "kUserSearchHistory"      // 用户的搜索历史记录key
let kIsLoadOnWIFI           = "kIsLoadOnWIFI"           // 仅仅在WIFI下加载图片 (默认关闭)
let kFontSize               = "kFontSize"               // 保存用户设置字体大小
let kUserCollection         = "kUserCollection"         // 保存用户收藏字典
let kUserReadHistory        = "kUserReadHistory"        // 保存用户阅读历史docId
let kIsFirstLaunch          = "kIsFirstLaunch"          // 第一次加载程序标识

/*********************** 其他 ***********************/

// MARK:- 自定义打印方法
func YDLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName):(\(lineNum))-\(message)")
    #endif
}

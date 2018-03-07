//
//  NXCommon.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/7.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

// MARK: API
let kNXChannelAPI   = "http://218.95.179.142/zzqapp/index.json"                     //栏目总入口
let kNXHomeAPI      = "http://218.95.179.142/zzqapp/sy/index.json"                  //首页新闻
let kNXGovAPI       = "http://218.95.179.142/zzqapp/qzf/index.json"                 //区政府
let kNXAffairAPI    = "http://218.95.179.142/zzqapp/wsbs/index.json"                //网上办事
let kNXProfileAPI   = "http://218.95.179.142/zzqapp/ggqy/cblsj/"                    //个人中心
let kNXSearchAPI    = "http://218.95.179.142/search/appsearch.jsp"                  //搜索

/** 全局间距 */
let kNXMargin : CGFloat = 12
/** 全局sectionH */
let kNXSectionH : CGFloat = 40

// MARK : 颜色相关
/** 系统主题颜色RGB */
let kThemeC                = UIColor.init(R: 32, G: 132, B: 255, Alpha: 1.0)
/** 全局背景色 */
let kBGC                   = UIColor.init(R: 250, G: 250, B: 250, Alpha: 1.0)
/** 全局cell分割线颜色 */
let kSeparateLineC         = UIColor.init(R: 230, G: 230, B: 230, Alpha: 1.0)
/** 全局灰色 */
let kGrayC                 = UIColor.init(R: 150, G: 150, B: 150, Alpha: 1.0)
/** 全局黑色 */
let kBlackC                = UIColor.init(R: 46, G: 46, B: 46, Alpha: 1.0)
/** 全局蓝色 */
let kBlueC                 = UIColor.init(R: 45, G: 93, B: 155, Alpha: 1.0)

// MARK: 其他
/** 全局根导航控制器 */
let kNXRootNavigationController = UIApplication.shared.keyWindow?.rootViewController as! NXNavigationController










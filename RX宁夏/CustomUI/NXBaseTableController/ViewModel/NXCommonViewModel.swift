//
//  NXCommonViewModel.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/22.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import SwiftyJSON

class NXCommonViewModel: NSObject {

    /** 主列表模型 */
    open var listModels: Observable<[NXCommonSectionModel]>
    
    /** 轮播模型 */
    open var bannerModels: Observable<[NXCommonModel]>
    
    /** 头部模型 */
    open var headerModel: Observable<NXCommonHeaderModel>
    
    /** 信箱模型 */
    open var mailboxModel: Observable<NXCommonMailBoxModel>
    
    /** 网上办事头部图片url */
    open var affairImageUrl: Observable<String>
    /** 下载器 */
    private let provider = MoyaProvider<API>()
    
    init(api: String) {
        
        let responseJson = provider.rx.request(.common(urlStr: api)).mapJSON().asObservable().yd_json { return JSON($0)["response"] }.share()

        listModels = responseJson.yd_json { return JSON($0)["datas"] }.mapArray(NXCommonSectionModel.self)
        
        bannerModels = responseJson.yd_json { return JSON($0)["topic_datas"] }.mapArray(NXCommonModel.self)
    
        headerModel = responseJson.yd_json {
                if JSON($0)["govern"] != JSON.null {
                    return JSON($0)["govern"]
                } else {
                    return JSON($0)["resume"]
                }
            }.mapObject(NXCommonHeaderModel.self)
        
        mailboxModel = responseJson.yd_json { JSON($0)["mailbox"] }.mapObject(NXCommonMailBoxModel.self)
        
        affairImageUrl = responseJson.yd_json { JSON($0)["topBackgroundImage"] }.map { return $0 as! String }
        
    }
}










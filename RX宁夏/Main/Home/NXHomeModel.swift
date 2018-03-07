//
//  NXHomeModel.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/22.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import Foundation
import ObjectMapper

struct NXHomeModel: Mappable {
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        channelId <- map["channelId"]
        channelType <- map["channelType"]
        channelTitle <- map["channelTitle"]
        channelUrl <- map["channelUrl"]
    }
    
    var channelId = -1
    var channelType = -1
    var channelTitle = ""
    var channelUrl = ""
}

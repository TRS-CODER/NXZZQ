//
//  NXCommonHeaderModel.swift
//  RX宁夏
//
//  Created by yudai on 2018/3/2.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import Foundation
import ObjectMapper

struct NXCommonHeaderLeaderTeamModel: Mappable {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        leaderName <- map["leaderName"]
        leaderUrl <- map["leaderUrl"]
    }
    
    var leaderName: String?
    var leaderUrl: String?
}

struct NXCommonHeaderReferenceModel: Mappable {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        channelId <- map["channelId"]
        docId <- map["docId"]
        showType <- map["showType"]
        clickType <- map["clickType"]
        docTitle <- map["docTitle"]
        docUrl <- map["docUrl"]
    }
    
    var channelId: Int?
    var docId: Int?
    var showType: Int?
    var clickType: Int?
    var docTitle: String?
    var docUrl: String?
    
}

struct NXCommonHeaderModel: Mappable {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        docId <- map["docId"]
        docTitle <- map["docTitle"]
        docUrl <- map["docUrl"]
        docImages <- map["docImages"]
        docMedia <- map["docMedia"]
        docTime <- map["docTime"]
        docSource <- map["docSource"]
        docContent <- map["docContent"]
        channelId <- map["channelId"]
        showType <- map["showType"]
        clickType <- map["clickType"]
        temp <- map["temp"]
        leaders <- map["leaderTeam"]
        references <- map["reference"]
    }
    
    var docId: String?
    var docTitle: String?
    var docUrl: String?
    var docImages: [String]?
    var docMedia: String?
    var docTime: String?
    var docSource: String?
    var docContent: String?
    var channelId: Int?
    var showType: Int?
    var clickType: Int?
    var temp: Int?
    var leaders: [NXCommonHeaderLeaderTeamModel]?
    var references: [NXCommonHeaderReferenceModel]?
}














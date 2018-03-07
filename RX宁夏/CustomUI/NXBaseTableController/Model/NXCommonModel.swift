//
//  NXCommonModel.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/23.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import Foundation
import ObjectMapper

struct NXCommonSectionModel: Mappable {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        channelTitle <- map["channelTitle"]
        channelUrl <- map["channelUrl"]
        channelItems <- map["channelItems"]
    }
    
    var channelTitle: String?
    var channelUrl: String?
    var channelItems: [NXCommonModel]?
}

struct NXCommonSubModel: Mappable {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        itemTitle <- map["itemTitle"]
        itemUrl <- map["itemUrl"]
    }
    
    var itemTitle: String?
    var itemUrl: String?
}

struct NXCommonModel: Mappable {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        channelId <- map["channelId"]
        docId <- map["docId"]
        showType <- map["showType"]
        clickType <- map["chickType"]
        docTitle <- map["docTitle"]
        docUrl <- map["docUrl"]
        docImages <- map["docImages"]
        docMedia <- map["docMedia"]
        docSource <- map["docSource"]
        content <- map["content"]
        docTime <- (map["docTime"],NXTimeFormater())
        subItems <- map["subItems"]
        
        // 互动相关
        interviewee <- map["interviewee"]
        intervieweeResume <- map["intervieweeResume"]
        interviewContent <- map["interviewContent"]
        interviewTime <- map["interviewTime"]
    }
    
    var channelId: Int?
    var docId: Int?
    var showType: Int?
    var clickType: Int?
    var docTitle: String?
    var docUrl: String?
    var docImages: [String]?
    var docMedia: String?
    var docSource: String?
    var content: String?
    var docTime: String?
    var subItems: [NXCommonSubModel]?
    
    // 互动相关
    var interviewee: String?
    var intervieweeResume: String?
    var interviewContent: String?
    var interviewTime: String?
}

struct NXCommonMailBoxModel: Mappable {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        mailboxTitle <- map["mailboxTitle"]
        mailboxBackgroundImage <- map["mailboxBackgroundImage"]
        mailboxUrl <- map["mailboxUrl"]
        showType <- map["showType"]
        clickType <- map["clickType"]
    }
    
    var mailboxTitle: String?
    var mailboxBackgroundImage: String?
    var mailboxUrl: String?
    var showType: Int?
    var clickType: Int?
}

// MARK: 模型内格式化时间类
class NXTimeFormater: TransformType {
    
    typealias Object = String
    
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> String? {
        guard let time = value as? String else { return nil }
        return time.subString(start: 0, length: 10)
    }
    
    func transformToJSON(_ value: String?) -> String? { return nil }

}










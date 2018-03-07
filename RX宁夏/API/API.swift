//
//  API.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/7.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import Moya

enum API {
    /// 主框架
    case main
    /// 首页
    case home
    /// 个人中心
    case profile
    /// 普通
    case common(urlStr: String)
}

extension API: TargetType {
    
    var baseURL: URL {
        switch self {
        case .common(let urlStr): return URL(string: urlStr)!
        default: return URL(string: "http://218.95.179.142")!
        }
    }
    
    var path: String {
        switch self {
        case .main:      return "zzqapp/index.json"
        case .home:      return "zzqapp/sy/index.json"
        case .profile:   return "zzqapp/ggqy/cblsj"
        case .common(_): return ""
        }
    }
    
    var method: Method { return .get }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    
    var task: Task { return .requestPlain }
    
    var headers: [String : String]? { return nil }
}



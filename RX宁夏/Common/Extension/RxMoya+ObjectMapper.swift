//
//  RxMoya+ObjectMapper.swift
//  Rx宁夏
//
//  Created by yudai on 2018/2/4.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import SwiftyJSON

extension ObservableType where E == Any {
    public func yd_json(_ json : @escaping ((E) -> JSON)) -> Observable<Any> {
        return flatMap { (result) -> Observable<Any> in
            return Observable.just(json(result).object)
        }
    }
    
    // 将Json解析为Observable<Model>
    public func mapObject<T: BaseMappable>(_ type: T.Type) -> Observable<T> {
        return flatMap { json -> Observable<T> in
            guard let object = Mapper<T>().map(JSONObject: json) else {
                YDLog("ObjectMapper can't mapping Object")
                return Observable.error(NSError(domain: "YD", code: -1, userInfo: [NSLocalizedDescriptionKey : "ObjectMapper can't mapping Object"]))
            }
            return Observable.just(object)
        }
    }
    
    // 将Json解析为 Observable<[Model]>
    public func mapArray<T: BaseMappable>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { (json) -> Observable<[T]> in
            guard let objectArr = Mapper<T>().mapArray(JSONObject: json) else {
                YDLog("ObjectMapper can't mapping Array")
                return Observable.error(NSError(domain: "YD", code: -1, userInfo: [NSLocalizedDescriptionKey : "ObjectMapper can't mapping objArray"]))
            }
            return Observable.just(objectArr)
        }
    }
}



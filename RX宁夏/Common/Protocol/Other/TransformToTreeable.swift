//
//  TransformToTreeable.swift
//  公安demo
//
//  Created by yudai on 2018/2/23.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import Foundation

protocol TransformToTreeable {
    
    var pId: String? { set get }
    var id: String? { set get }
    var childrenModels: [TransformToTreeable]? { set get }
}

extension Array {
    
    /// 把json数组转树形结构
    ///
    /// - Parameters:
    ///   - rawModels: 原始json模型数组
    ///   - rootNode: 根节点名称
    ///   - parentNode: 父节点名称
    ///   - childrenNode: 子节点名称
    /// - Returns: 转换后的🌲
//    func rawModelsToTree(rawModels: [TransformToTreeable], rootNode: String, parentNode: String, childrenNode: String) -> [TransformToTreeable] {
//        // 0. 创建根节点
//        let rootModels = rawModels.filter { $0.pId == rootNode }
//
//        for model1 in rawModels {
//            // 1. 配置根节点
//            for rootModel in rootModels {
//                if rootModel.id == model1.pId {
//                    rootModel.subModel.append(model1)
//                }
//            }
//
//            // 2. 配置子节点
//            for model2 in rawModels {
//                // 2.1 之前配置过的根节点排除
//                guard rootModels.contains(model1) == false && rootModels.contains(model2) == false else { continue }
//                if model1.id == model2.pId { // model1是model2的父
//                    model1.subModel.append(model2)
//                } else if model2.id == model1.pId { // model1是model2的子
//                    model2.subModel.append(model1)
//                }
//            }
//        }
//        return rootModels
//    }
    
}

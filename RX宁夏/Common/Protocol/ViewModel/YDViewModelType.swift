//
//  YDViewModelType.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/7.
//  Copyright © 2018年 拓尔思. All rights reserved.
//
import UIKit

protocol YDViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

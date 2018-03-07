//
//  Runtime+NSObject.swift
//  ENJOY
//
//  Created by yudai on 2018/1/10.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

extension NSObject {
    
    /// 通过类名创建一个控制器(swift3.0)
    ///
    /// - parameter VCName: 控制器的名称(String)
    ///
    /// - returns: 创建好的控制器
    class func createVC(_ VCName: String) -> UIViewController? {
        // 从info.plist读取namespace
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 拼接类名的完整格式,即namespace.类名,vcName即控制器的类名
        let clsName = namespace + "." + VCName
        let cls : AnyClass? = NSClassFromString(clsName)
        if let VC = cls as? UIViewController.Type {
            return VC.init()
        }
        return nil
    }
    
    /// 动态交换两个方法的实现
    ///
    /// - Parameters:
    ///   - cls: 哪个类的方法
    ///   - originalSelector: 原始方法名
    ///   - swizzeSelector: 替换的方法名
    public class func methodSwizze(cls: AnyClass, originalSelector: Selector, swizzeSelector: Selector)  {
        let originalMethod = class_getInstanceMethod(cls, originalSelector)
        let swizzeMethod = class_getInstanceMethod(cls, swizzeSelector)
        
        let didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzeMethod!), method_getTypeEncoding(swizzeMethod!))
        
        if didAddMethod {
            class_replaceMethod(cls, swizzeSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        }else {
            method_exchangeImplementations(originalMethod!, swizzeMethod!)
        }
    }
    
    /// 动态打印所有成员变量
    ///
    /// - Parameter cls: 需要打印的类
    public class func printProperty(cls: AnyClass) {
        var count: UInt32 = 0
        let ivars = class_copyIvarList(cls, &count)
        print("*************** \(cls) 的属性列表 ***************")
        for i in 0 ..< count {
            let ivar = ivars![Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        print("*************** \(cls) 的属性列表 ***************")
        free(ivars)
    }
    
    /// 动态打印方法列表
    ///
    /// - Parameter cls: 需要打印的类
    public class func printMethodList(cls: AnyClass) {
        var count: UInt32 = 0
        let methods = class_copyMethodList(cls, &count)
        print("*************** \(cls) 的方法列表 ***************")
        for i in 0 ..< count {
            let method = methods![Int(i)]
            let methodName = method_getName(method)
            print(methodName)
        }
        print("*************** \(cls) 的方法列表 ***************")
    }
    
}

//
//  YDWebImageTool.swift
//  ENJOY
//
//  Created by yudai on 2018/1/10.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit
import Kingfisher
import Reachability

class YDWebImageTool {
    
    class func setImage(with urlStr : String, needsSetImageView imageView : UIImageView ,placeholder: UIImage? = nil) {
        let bool = UserDefaults.standard.bool(forKey: kIsLoadOnWIFI)
        if bool {
            let reach = Reachability()
//            let isWiFi =  == .wifi ? true : false
            if !reach.isReachableViaWiFi() {
                imageView.kf.setImage(with: URL(string : urlStr), placeholder: placeholder, options: [.onlyFromCache,.transition(.fade(0.5))])
                return
            }
        }
        imageView.kf.setImage(with: URL(string : urlStr), placeholder: placeholder, options: [.transition(.fade(0.5))])
    }
    
    class func clearMemoryCahe() {
        KingfisherManager.shared.cache.clearMemoryCache()
    }
    
    /// 给下载图片添加处理
    ///
    /// - Parameters:
    ///   - urlStr: 下载url
    ///   - imageView: 需要设置的imageVIew
    class func setImageWithProccess(with urlStr: String, to imageView: UIImageView, proccess: DefaultImageProcessor) {
        // 创建方法示例
//        let proccess = DefaultImageProcessor()
//        let radius = imageView.width / 2.0
//        let roundImageProccess = RoundCornerImageProcessor(cornerRadius: radius)
//        let colorImageProccess = ColorControlsProcessor(brightness: 2, contrast: 20, saturation: 1, inputEV: 10)
//        let imageProccess = proccess.append(another: colorImageProccess).append(another: roundImageProccess)
        
        imageView.kf.setImage(with: URL(string : urlStr), placeholder: nil, options: [.processor(proccess)], progressBlock: nil, completionHandler: nil)
    }
    
}












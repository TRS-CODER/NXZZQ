//
//  YDTabBar.swift
//  中国·宁夏
//
//  Created by yudai on 2017/12/1.
//  Copyright © 2017年 拓尔思. All rights reserved.
//

import UIKit

/**************************** 对外配置参数 ****************************/
let kImageWH : CGFloat = 16.67
let kTitleH : CGFloat = 12
let kTitleNormalC : UIColor = UIColor(R: 96, G: 152, B: 211, Alpha: 1)
let kTitleSelectedC : UIColor = UIColor.white
let kTabBarBGC : UIColor = kBlueC

// 按钮图片的y值
let kImageY : CGFloat = 8
/**************************** 对外配置参数 ****************************/

class YDTabBar: UIView {

    /** 按钮模型数据 */
    open var tabbarModels = [YDTabBarItemModel]()
    
    /** 外部选中控制器序号 */
    open var selectedIndex: Int? {
        didSet{
            btns[selectedIndex!].isSelected = true
            selectedBtn?.isSelected = false
            selectedBtn = btns[selectedIndex!]
            selectedBtn?.bounceEffect()
        }
    }
    
    /** 当前选中按钮 */
    private var selectedBtn: YDTabBarButton?
    
    /** 所有按钮数组 */
    private var btns = [YDTabBarButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = bounds.width / CGFloat(btns.count)
        for (index,btn) in btns.enumerated() {
            btn.frame = CGRect(x: w * CGFloat(index), y: 0, width: w, height: bounds.height)
        }
    }
}

extension YDTabBar {
    fileprivate func setupUI() {
        // 设置背景色
        backgroundColor = kTabBarBGC
        
        // 加载框架信息
        let dictArray = NSArray(contentsOfFile: Bundle.main.path(forResource: "项目框架.plist", ofType: nil)!) as! [[String : String]]
        dictArray.forEach {
            let model = YDTabBarItemModel(dict: $0)
            tabbarModels.append(model)
        }
        
        // 设置按钮
        for (index,model) in tabbarModels.enumerated() {
            let btn = YDTabBarButton(itemModel: model)
            btn.tag = index
            addSubview(btn)
            btns.append(btn)
        }
    }
}

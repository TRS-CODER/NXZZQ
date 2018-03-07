//
//  NXHtmlController.swift
//  RX宁夏
//
//  Created by yudai on 2018/3/6.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit
import SnapKit

class NXHtmlController: UIViewController {

    private let navBar = NXDetailNavBar()
    
    private lazy var webView: YDWebView = {
        let wv = YDWebView(frame: CGRect.zero)
        wv.api = "http://www.nx.gov.cn/"
        return wv
    }()
    
    private lazy var toolBar: NXToolbar = {
        let tb = NXToolbar.toolbar()
        return tb
    }()
    
    private lazy var changeFontView : SNSettingWebFontView = {
        let changeFontView = SNSettingWebFontView.creatFontView()
        return changeFontView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        initEvent()
    }

}

extension NXHtmlController {
    private func initUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(navBar)
        view.addSubview(webView)
        view.addSubview(toolBar)
        
        navBar.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.width.equalTo(kScreenW)
            make.height.equalTo(kNavBarH())
        }
        
        webView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(navBar.snp.bottom)
            make.bottom.equalTo(toolBar.snp.top)
        }
        
        toolBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(kTabBarH())
        }
    }
    
    private func initEvent() {
        navBar.itemClicked = { [weak self] (model) in
            switch model.type {
            case .font: self?.changeFontView.show()
            case .back: self?.navigationController?.popViewController(animated: true)
            default: break
            }
        }
        
        changeFontView.fontDidChangeClosure = { [weak self] (size) in
            self?.setHTMLFont(size: size)
        }
    }
    
    private func setHTMLFont(size : CGFloat) {
        var fontSize : CGFloat = 0.0
        switch size {
        case 0 : fontSize = 0.6 * 100
        case 1 : fontSize = 0.8 * 100
        case 2 : fontSize = 1 * 100
        case 3 : fontSize = 1.2 * 100
        case 4 : fontSize = 1.4 * 100
        default: break
        }
        let str = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(fontSize)%'"
        webView.evaluateJavaScript(str, completionHandler: nil)
    }
}












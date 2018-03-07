//
//  YDWebView.swift
//  RX宁夏
//
//  Created by yudai on 2018/3/6.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit
import WebKit

fileprivate let ProgressViewH : CGFloat = 4
fileprivate let ProgressKeyPath = "estimatedProgress"
fileprivate let ProgressViewC : UIColor = UIColor.red

enum YDWebViewLoadState {
    case success
    case failed
}

class YDWebView: WKWebView {
    
    open var api: String? {
        didSet{
            load(URLRequest(url: NSURL(string: api!)! as URL))
        }
    }
    
    open var loadDidFinishedBlock: ((_ webView : YDWebView, _ loadState: YDWebViewLoadState) -> Void)?
    
    private lazy var progressView: UIProgressView = {
        let pv = UIProgressView()
        pv.progressTintColor = ProgressViewC
        return pv
    }()
    
    init(frame : CGRect) {
        let configuration = WKWebViewConfiguration()
        super.init(frame: frame, configuration:configuration)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: ProgressViewH)
    }
    
    deinit {
        removeObserver(self, forKeyPath: ProgressKeyPath)
        /// 重置progressView
        progressView.reloadInputViews()
        print("YDWebView ------------------- deinit")
    }
    
}

extension YDWebView {
    private func initUI() {
        isOpaque = false
        backgroundColor = UIColor.clear
        navigationDelegate = self
        uiDelegate = self
        addSubview(progressView)
        addObserver(self, forKeyPath: ProgressKeyPath, options:.new, context: nil)
    }
    
    // MARK:- 监听进度条
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == ProgressKeyPath) {
            // 加载完成后隐藏进度条&重置进度
            if estimatedProgress > 0.99 {
                progressView.isHidden = true
                progressView.progress = 0
            }
            // webView内部重新加载的情况
            if estimatedProgress > 0.1 && estimatedProgress <= 0.99 {
                progressView.isHidden = false
            }
            progressView.setProgress(Float(estimatedProgress), animated: true)
//            print(estimatedProgress)
            if estimatedProgress == 1 {  // 不知道什么原因断网的情况下estimatedProgress也会到1来
                //                loadDidFinishedClosure?(self,loadState)
            }
        }
    }
}

extension YDWebView: WKNavigationDelegate, WKUIDelegate {
    
    /** 加载成功后调用 */
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadDidFinishedBlock?(self, YDWebViewLoadState.success)
    }
    
    /** 网页加载失败后调用(在estimatedProgress变为1之前) */
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        loadDidFinishedBlock?(self, YDWebViewLoadState.failed)
    }
    
    /** 解决网页内链中是打开新网页点击后没反应的情况 */
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            _ = webView.load(navigationAction.request)
        }
        return nil
    }
    
}
























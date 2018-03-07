//
//  NXAffairController.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/5.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

class NXAffairController: UIViewController {

    open var edgePanBlock: ((UIScreenEdgePanGestureRecognizer) -> Void)?
    
    private var viewModel: NXCommonViewModel!
    
    private var dataSource: [NXCommonSectionModel]?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: YDCommonItemW, height: YDCommonItemH)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.register(YDCommonItem.self, forCellWithReuseIdentifier: YDCommonItemID)
        cv.register(NXAffairHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: NXAffairHeaderID)
        cv.register(UINib(nibName: "NXOnlineAffImageHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kNXOnlineAffImageHeaderID)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.white
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    private lazy var edgeGes: UIScreenEdgePanGestureRecognizer = {
        let eg = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(gesActivated(ges:)))
        eg.edges = .left
        return eg
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initEvent()
        bindUI()
    }
    
}

extension NXAffairController {
    private func initUI() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(kNavBarH())
            make.height.equalTo(kScreenH-kNavBarH()-kTabBarH())
        }
    }
    
    private func initEvent() {
        view.addGestureRecognizer(edgeGes)
    }
    
    private func bindUI() {
        viewModel = NXCommonViewModel(api: kNXAffairAPI)
        
        viewModel.listModels.subscribe(onNext: { [weak self] (dataSource) in
            self?.dataSource = dataSource
            self?.collectionView.reloadData()
        }).disposed(by: rx.disposeBag)
    }
    
    @objc private func gesActivated(ges: UIScreenEdgePanGestureRecognizer) {
        edgePanBlock?(ges)
    }
}

extension NXAffairController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource![section].channelItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YDCommonItemID, for: indexPath)
        (cell as! YDCommonItem).model = dataSource![indexPath.section].channelItems?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 { // 第一个特殊header
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kNXOnlineAffImageHeaderID, for: indexPath)
            // 1. 本身传值
            (header as! NXOnlineAffImageHeader).model = dataSource?[indexPath.section]
            // 2. 图片url传递
            viewModel.affairImageUrl.subscribe(onNext: { (str) in
                (header as! NXOnlineAffImageHeader).imageUrl = str
            }).disposed(by: rx.disposeBag)
            return header
        } else { // 默认普通header
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: NXAffairHeaderID, for: indexPath)
            (header as! NXAffairHeader).model = dataSource?[indexPath.section]
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: kScreenW, height: NXOnlineAffImageHeaderImageH + kNXSectionH)
        } else {
            return CGSize(width: kScreenW, height: kNXSectionH)
        }
    }
    
}
























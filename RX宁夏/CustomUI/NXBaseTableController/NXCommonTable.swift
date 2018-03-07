//
//  NXCommonTable.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/22.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

let NXCommonTableMailboxH: CGFloat = kScreenW * 428 / 1080
class NXCommonTable: UITableViewController {
    
    private var viewModel: NXCommonViewModel!
    
    private var bannerModels: [NXCommonModel]?
    
    private var listModels: [NXCommonSectionModel]?
    
    /** 焦点轮播器 */
    private lazy var banner: ParallexBanner = {
        let banner = ParallexBanner()
        // 比较特殊不用snapKit进行约束(第三方插件)
        banner.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenW/16*9)
        banner.dataSource = self
        banner.delegate = self
        return banner
    }()
    
    /** tableHeaderView */
    private var tableHeader: NXBaseTableHeader?
    
    private lazy var mailboxBtn: UIButton = {
        let mb = UIButton()
        mb.backgroundColor = UIColor.white
        return mb
    }()
    
    init(api: String) {
        super.init(style: .plain)
        self.viewModel = NXCommonViewModel(api: api)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindUI()
    }

}

extension NXCommonTable {
    private func initUI() {
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        //预估值随意写一个差不多的就可以
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func bindUI() {
        viewModel.listModels.subscribe(onNext: { [weak self] (listModels) in
            self?.listModels = listModels
            self?.tableView.reloadData()
        }).disposed(by: rx.disposeBag)
        
        viewModel.bannerModels.subscribe(onNext: { [weak self] (bannerModels) in
            self?.tableView.setAndLayoutTableHeaderView(header: (self?.banner)!)
            self?.bannerModels = bannerModels
            self?.banner.reloadData()
        }, onError: nil).disposed(by: rx.disposeBag)

        viewModel.headerModel.subscribe(onNext: { [weak self] (dataSource) in
            self?.tableHeader = NXBaseTableHeader(dataSource: dataSource)
            self?.tableView.setAndLayoutTableHeaderView(header: (self?.tableHeader)!)
        }, onError: nil).disposed(by: rx.disposeBag)
        
        viewModel.mailboxModel.subscribe(onNext: { [weak self] (model) in
            self?.configMailbox(model: model)
        }, onError: nil).disposed(by: rx.disposeBag)
    }
    
    private func configMailbox(model: NXCommonMailBoxModel) {
        mailboxBtn.frame = CGRect(x: 0, y: 0, width: kScreenW, height: NXCommonTableMailboxH)
        tableView.tableFooterView = mailboxBtn
        mailboxBtn.kf.setBackgroundImage(with: URL(string: model.mailboxBackgroundImage!), for: .normal)
    }
}

extension NXCommonTable {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return listModels?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let sectionModel = listModels![section]
        switch sectionModel.channelTitle {
        case "组织机构"?:
            return 1
        default:
            return listModels?[section].channelItems?.count ?? 0
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if listModels![indexPath.section].channelTitle == "组织机构" { // 特殊cell
            let cell = NXInstitutionCell.tableViewCell(tableView: tableView, dataSource: listModels![indexPath.section].channelItems!)
            return cell
        } else { // 普通cell
            let model = listModels![indexPath.section].channelItems![indexPath.row]
            switch model.showType! {
            case 1:
                let cell = YDRightImageCell.tableViewCell(tableView: tableView)
                cell.model = model
                return cell
            case 2:
                let cell = YDOnlyTitleCell.tableViewCell(tableView: tableView)
                cell.model = model
                return cell
            case 3:
                let cell = YDBigImageCell.tableViewCell(tableView: tableView)
                cell.model = model
                return cell
            case 4: // 访谈类别
                let cell = YDComplexCell.tableViewCell(tableView: tableView)
                cell.model = model
                return cell
            default:
                let cell = UITableViewCell(style: .default, reuseIdentifier: "error")
                cell.textLabel?.text = "抱歉,数据错误,请稍后再试"
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kSectionH
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = NXCommonHeader.headerView(tableView: tableView)
        header.sectionModel = listModels?[section]
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destVC = NXHtmlController()
//        destVC.
        navigationController?.pushViewController(destVC, animated: true)
    }
    
}

extension NXCommonTable: ParallexBannerDelegate, ParallexBannerDataSource {
    
    func banner(banner: ParallexBanner, didClickAtIndex index: NSInteger) { }
    
    func banner(banner: ParallexBanner, didScrollToIndex index: NSInteger) { }
    
    func numberOfBannersIn(bannner: ParallexBanner) -> NSInteger {
        return bannerModels?.count ?? 0
    }
    
    func banner(banner: ParallexBanner, imageAt index: NSInteger) -> BannerItem {
        return BannerItem(imageUrl: bannerModels![index].docImages?[0], title: bannerModels![index].docTitle!, color: UIColor.clear)
    }
    
}

















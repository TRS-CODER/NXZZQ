//
//  NXTsetViewController.swift
//  RX宁夏
//
//  Created by yudai on 2018/2/12.
//  Copyright © 2018年 拓尔思. All rights reserved.
//

import UIKit

class NXTsetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kBlueC
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("NXTsetViewController -----deinit")
    }
}

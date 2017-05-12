//
//  WBHomeViewController.swift
//  Weibo
//
//  Created by 韩双 on 17/5/10.
//  Copyright © 2017年 HS. All rights reserved.
//

import UIKit

class WBHomeViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func showFriend() {
        let vc = WBProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension WBHomeViewController {
    
    // MARK: 设置界面
    override func setupUI() {
        super.setupUI()
        // Swift调用 OC 中的 instancetype 方法时，判断不出是否可选
//        let leftItem: UIButton = UIButton.cz_textButton("好友", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
//        leftItem.addTarget(self, action: #selector(showFriend), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftItem)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriend) )
    }
    
    
}

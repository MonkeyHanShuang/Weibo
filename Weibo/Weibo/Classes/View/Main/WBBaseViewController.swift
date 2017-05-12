//
//  WBBaseViewController.swift
//  Weibo
//
//  Created by 韩双 on 17/5/10.
//  Copyright © 2017年 HS. All rights reserved.
//

import UIKit


/// 主控制器
class WBBaseViewController: UIViewController {

    /// 自定义导航条
    lazy var navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    /// 自定义导航条目，以后设置导航栏内容 统一使用 navItem
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // 重写title的 didSet（ OC 中的 setter方法）
    override var title: String? {
        didSet {
            
            navItem.title = title
        }
    }
}

extension WBBaseViewController {

    func setupUI() {
        view.backgroundColor = UIColor.cz_random()
     
        // 添加导航栏
        view.addSubview(navBar)
        
        // 将 Item设置给 Bar
        navBar.items = [navItem]
        
        // 设置 navBar的 渲染颜色
        navBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        
        //  设置navBar的字体颜色
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]
    }
    
}


//
//  WBNavgationController.swift
//  Weibo
//
//  Created by 韩双 on 17/5/10.
//  Copyright © 2017年 HS. All rights reserved.
//

import UIKit

class WBNavgationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 隐藏默认的navgationbar
        navigationBar.isHidden = true
        
    }
    
    /// 重写push方法 所有的push都会执行此方法
    /// ViewController 是被 push 的按钮，设置它左侧的按钮，作为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 如果不是栈底控制器才需要隐藏
        if viewControllers.count > 0 {
            // 隐藏底部
            viewController.hidesBottomBarWhenPushed = true
            // 判断控制器的类型
            if let vc = viewController as? WBBaseViewController {
                var title = "返回"
                
                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? "返回"
                }
                // 取出自定义的 navItem
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, fontSize: 16, target: self, action: #selector(popToParent), isBack: true)
//                (title: title, target: self, action: #selector(popToParent)
            }
        }
        
        
        super.pushViewController(viewController, animated: true)
    }
    
    // POP 返回到上一级控制器
    @objc private func popToParent() {
        popViewController(animated: true)
    }
}

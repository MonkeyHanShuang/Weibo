//
//  UIBarButtonItem+Extensions.swift
//  Weibo
//
//  Created by 韩双 on 17/5/11.
//  Copyright © 2017年 HS. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 创建UIBarButtonItem
    ///
    /// - parameter title:    title
    /// - parameter fontSize: fontSize 默认16号
    /// - parameter target:   target
    /// - parameter action:   action
    /// - parameter isBack:   如果是返回按钮 加上箭头
    ///
    /// - returns: UIBarButtonItem
    convenience init(title: String, fontSize: CGFloat = 16, target: AnyObject?, action: Selector, isBack: Bool = false) {
        let leftItem: UIButton = UIButton.cz_textButton(title, fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        leftItem.addTarget(target, action: action, for: .touchUpInside)
        
        if isBack {
            let imageName = "navigationbar_back_withtext"
            
            leftItem.setImage(UIImage.init(named: imageName), for: .normal)
            leftItem.setImage(UIImage.init(named: imageName + "_highlighted"), for: .highlighted)
            
            leftItem.sizeToFit()
        }
        
        // self.init 实例化 UIBarButtonItem
        
        self.init(customView: leftItem )
    }
}

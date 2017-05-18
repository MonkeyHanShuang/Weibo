//
//  WBMainViewController.swift
//  Weibo
//
//  Created by 韩双 on 17/5/10.
//  Copyright © 2017年 HS. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewControllers()
        setupCompossBtn()
    }
    
    /**
     portrait : 竖屏，肖像
     landscape: 竖屏，风景画
      - 使用代码控制方向，好处：可以在横屏的时候单独处理
      - 设置支持的方向之后，当前的控制器及子控制器都会遵守这个方向
      - 如果播放视频 通常是通过 modal 展现的！
     
     */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return .portrait
    }
    
    lazy var composeBtton: UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add",
                                                                       backgroundImageName: "tabbar_compose_button")
    // Mark: 撰写按钮的监听方法
    func composeStatus() {
        print("撰写")
    }
}
// 相当于 OC 的分类
// 可以吧相近的放在一起
extension WBMainViewController {
    
    /// 设置撰写按钮
    func setupCompossBtn() {
        tabBar.addSubview(composeBtton)
        
        // 计算按钮宽度
        let count = CGFloat(childViewControllers.count)
        let w = tabBar.bounds.width / count - 1
        
        // CGRectInset 正数向内缩进， 负数向外扩展
        composeBtton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        composeBtton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    /// 设置所有子控制器
    func setupChildViewControllers() {
        
        // 从 Bundle 加载配置的 json
        // 1. 路径 2. 加载 Data  3.反序列化转化为数组
        guard let path = Bundle.main.path(forResource: "main.json", ofType: nil),
            let data = NSData(contentsOfFile: path),
        let array = try? JSONSerialization.jsonObject(with: data as Data, options: []) as! [[String: Any]]
            else {
                return
        }

//        // 直接保存到本地沙盒
//        // (array as NSArray).write(toFile: "/Users/hanshuang/Desktop/demo.plist", atomically: true)
//        
//        let data = try! JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
//        (data as NSData).write(toFile: "/Users/hanshuang/Desktop/demo.json", atomically: true)
        
        
        var array_M = [UIViewController]()
        
        for dict in array {
            array_M.append(controller(dict: dict))
        }
        viewControllers = array_M
    }
    
    // MARK: 使用字典创建所有的子控制器
    private func controller(dict: [String: Any]) -> UIViewController {
        
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.namespasce + "." + clsName) as? WBBaseViewController.Type,
            let visitorInfo = dict["visitorInfo"] as? [String: String]
            else {
            return UIViewController()
        }
        
        let vc = cls.init()
        vc.title = title
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .highlighted)
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.visitorDict = visitorInfo
        
        // 实例化导航控制器的时候，会调用push 讲rootVC 压栈
        let nav = WBNavgationController(rootViewController: vc)
        return nav
    }
    
}

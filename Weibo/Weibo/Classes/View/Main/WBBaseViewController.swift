//
//  WBBaseViewController.swift
//  Weibo
//
//  Created by 韩双 on 17/5/10.
//  Copyright © 2017年 HS. All rights reserved.
//

import UIKit

// Swift中，利用 extension可以把函数按照功能分类管理，便于阅读和维护
/**
   注意：
   extension 不能有属性，不能重写父类方法！重写父类方法是子类的职责，扩展是类的扩展
 
 */


/// 所有主控制器的基类控制器
class WBBaseViewController: UIViewController {

    // 用户登录标记
    var userLogon = false
    // 访客是视图信息
    var visitorDict: [String: String]?
    
    var tableView: UITableView?
    var refreshControl: UIRefreshControl?
    var isPullup = false
    
    /// 自定义导航条
    lazy var navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    /// 自定义导航条目，以后设置导航栏内容 统一使用 navItem
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupUI()
        
        loadData()
    }
    
    func loadData() {
        // 如果子类不实现任何方法，默认关闭刷新控件
        refreshControl?.endRefreshing()
    }
    
    // 重写title的 didSet（ OC 中的 setter方法）
    override var title: String? {
        didSet {
            
            navItem.title = title
        }
    }
}

// MARK: - 设置页面
extension WBBaseViewController {

    func setupUI() {
         
        setupNavigationBar()
        userLogon ? setupTableView() : setupVisitorView()
        
    }
    
    private func setupTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navBar)
        
        tableView?.dataSource = self
        tableView?.delegate = self
        
        // 设置内容缩进
        tableView?.contentInset = UIEdgeInsets.init(top: navBar.bounds.height, left: 0, bottom: navBar.bounds.height , right: 0)
        
        // 设置刷新空间
        // 1. 实例化空间
        refreshControl = UIRefreshControl()
        
        // 2. 添加空间到表格视图
        tableView?.addSubview(refreshControl!)
        
        // 3. 添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    // MARK: - 设置访客视图
    private func setupVisitorView() {
        
        let visitorView = WBVisitor(frame: view.bounds)
        view.insertSubview(visitorView, belowSubview: navBar)
        // 设置访客视图信息
        visitorView.visitorInfo = visitorDict
        
        
    }
    
    private func setupNavigationBar() {
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

// MARK: - UITableViewDelegate, UITableViewDataSource
extension WBBaseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // 基类只是准备方法，子类负责具体的实现.
    // 子类的数据源方法不用 super
    // 只是保证没有语法错误
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // 在最后一行的时候做上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 1. 判断是否是最后一行
        //  ->row
        let row = indexPath.row;
        //  ->section
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            return
        }
        
        // 2. 行数
        let count = tableView.numberOfRows(inSection: section)
        
        // 如果是最后一行并且没有上拉刷新
        if row == (count - 1) && !isPullup {
            // 上拉刷新
            isPullup = true
            print("上拉刷新")
            loadData()
        }
        
    }
    
}


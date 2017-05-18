//
//  WBHomeViewController.swift
//  Weibo
//
//  Created by 韩双 on 17/5/10.
//  Copyright © 2017年 HS. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class WBHomeViewController: WBBaseViewController {

    lazy var statusList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func showFriend() {
        let vc = WBProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 加载数据
    override func loadData() {
        
        // 模拟延时加载数据 -> dispatch_after 延时加载数据
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            
            for i in 0...20 {
                
                if self.isPullup {
                    
                    // 将数据插入到数组的底部
                    self.statusList.append("上拉 \(i)")
                } else {
                    // 将数据插入到数组的顶部
                    self.statusList.insert(i.description, at: 0)
                }
            }
            
            print("加载数据完毕")
            // 结束刷新控件
            self.refreshControl?.endRefreshing()
            // 恢复上拉刷新标记
            self.isPullup = false
            
            // 刷新表格
            self.tableView?.reloadData()
        }
        
    }

}

// MARK: - 表格数据源方法，具体的数据源方法的实现，不需要super
extension WBHomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = statusList[indexPath.row]
        
        return cell
        
    }
}

// MARK: - 设置页面
extension WBHomeViewController {
    
    // MARK: - 设置界面
    override func setupUI() {
        super.setupUI()

        // 取消自动缩进 - 如果隐藏了导航栏会缩进20个点
        automaticallyAdjustsScrollViewInsets = false
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriend) )
        
        // 注册原型cell
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    
}

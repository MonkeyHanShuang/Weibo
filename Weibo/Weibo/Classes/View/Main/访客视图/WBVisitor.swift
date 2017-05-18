//
//  WBVisitor.swift
//  Weibo
//
//  Created by 韩双 on 17/5/14.
//  Copyright © 2017年 HS. All rights reserved.
//

import UIKit


/// 访客视图
class WBVisitor: UIView {
    
    var visitorInfo: [String: String]? {
        didSet {
            // 1- 取字典信息
            guard let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"] else {
                    return
            }
            
            // 2- 设置消息
            tipsLable.text = message
            
            // 3- 设置图像 首页不需要设置
            if imageName == "" {
                startAnimation()
                return
            }
            iconView.image = UIImage.init(named: imageName)

            // 其他控制器的访客视图不需要小房子
            houseView.isHidden = true;
            maskIconImage.isHidden = true
        }
    }
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 旋转图标动画
    private func startAnimation() {
    
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * M_PI
        animation.repeatCount = MAXFLOAT
        animation.duration = 10
        // 动画完成不删除，如果 iconView被释放，动画被一起销毁
        // 在设置连续播放的动画上非常有用
        animation.isRemovedOnCompletion = false
        
        // 将动画添加到图层
        iconView.layer.add(animation, forKey: nil)
    }
    
    // MARK: - 私有控件
    // 懒加载属性只有调用 UIKit 控件的指定构造函数，其他的都需要指定类型（最好都指定类型）
    /// 图像视图
    lazy var iconView: UIImageView = UIImageView(image: UIImage.init(named: "visitordiscover_feed_image_smallicon"))
    
    /// 图像遮罩
    lazy var maskIconImage: UIImageView = UIImageView(image: UIImage.init(named: "visitordiscover_feed_mask_smallicon"))
    
    /// 小房子
    lazy var houseView: UIImageView = UIImageView(image: UIImage.init(named: "visitordiscover_feed_image_house"))

    /// 提示标签
    lazy var tipsLable: UILabel = UILabel.cz_label(withText: "关注一些人，回这里看看有什么惊喜，登录之后会出现什么呢，快去看看吧",
                                                   fontSize: 14,
                                                   color: UIColor.darkGray)

    /// 注册按钮
    lazy var registBtn: UIButton = UIButton.cz_textButton("注册", fontSize: 16,
                                                          normalColor: UIColor.orange,
                                                          highlightedColor: UIColor.black,
                                                          backgroundImageName: "common_button_white_disable")
    /// 登录按钮
    lazy var loginBtn: UIButton = UIButton.cz_textButton("登录", fontSize: 16,
                                                         normalColor: UIColor.darkGray,
                                                         highlightedColor: UIColor.black,
                                                         backgroundImageName: "common_button_white_disable")

}

// MARK: - 设置界面
extension WBVisitor {
    
    func setupUI() {
        
        backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        
        // 1.添加控件
        addSubview(iconView)
        addSubview(maskIconImage)
        addSubview(houseView)
        addSubview(tipsLable)
        addSubview(registBtn)
        addSubview(loginBtn)
        
        // 文本居中
        tipsLable.textAlignment = .center
        
        // 2.取消autoresizing
        
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 3.自动布局
        // 1> 图像视图
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60))
        
        // 小房子
        addConstraint(NSLayoutConstraint(item: houseView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        // 提示标签
        addConstraint(NSLayoutConstraint(item: tipsLable, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipsLable, attribute: .top, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: 10))
        addConstraint(NSLayoutConstraint(item: tipsLable, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 237))
        
        // 注册按钮
        addConstraint(NSLayoutConstraint(item: registBtn, attribute: .left, relatedBy: .equal, toItem: tipsLable, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registBtn, attribute: .top, relatedBy: .equal, toItem: tipsLable, attribute: .bottom, multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: registBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        
        // 登录按钮
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .right, relatedBy: .equal, toItem: tipsLable, attribute: .right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .top, relatedBy: .equal, toItem: tipsLable, attribute: .bottom, multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        
        // 图像遮罩(VFL)
           /**
             views -> 定义 VFL 中的控件名称和实际名称的映射关系
             metrics -> 定义 VFL 中 指定的常数映射关系
            */
        let viewDict = ["maskIconImage": maskIconImage,
                        "registBtn": registBtn] as [String : Any]
        let metrics = ["spacing": 15]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[maskIconImage]-0-|", options: [], metrics: nil, views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[maskIconImage]-(spacing)-[registBtn]", options: [], metrics: metrics, views: viewDict))
    }
    
    
    
}

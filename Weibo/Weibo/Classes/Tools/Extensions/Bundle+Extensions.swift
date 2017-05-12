//
//  Bundle+Extensions.swift
//  Weibo
//
//  Created by 韩双 on 17/5/10.
//  Copyright © 2017年 HS. All rights reserved.
//

import UIKit

extension Bundle {

    var namespasce: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    
}

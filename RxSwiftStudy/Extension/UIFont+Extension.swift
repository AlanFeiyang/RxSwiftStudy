//
//  UIFont+Extension.swift
//  ProjectBuild
//
//  Created by xc on 2019/12/2.
//  Copyright © 2019 四川隧唐科技股份有限公司. All rights reserved.
//

import Foundation

extension UIFont {
    
    //列表文字字号
    @nonobjc class var listFont: UIFont {
        let size:CGFloat = IsBigScreen ? 15 : 13
        return UIFont.systemFont(ofSize: size)
    }
    
    //主要文字字号
    @nonobjc class var mainFont: UIFont {
        let size:CGFloat = IsBigScreen ? 18 : 16
        return UIFont.systemFont(ofSize: size)
    }
    
    //标题、导航栏
    @nonobjc class var titleFont: UIFont {
        let size:CGFloat = IsBigScreen ? 21 : 19
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    //个人中心用户名称
    @nonobjc class var centerNameFont: UIFont {
        let size:CGFloat = IsBigScreen ? 24 : 21
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    
    //分段选择器标题字
    @nonobjc class var segmentNormalFont: UIFont {
        let size:CGFloat = IsBigScreen ? 18 : 16
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight(rawValue: 1.0))
    }
    
    @nonobjc class var segmentSelectedFont: UIFont {
        let size:CGFloat = IsBigScreen ? 21 : 19
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight(rawValue: 1.0))
    }
}


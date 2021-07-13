//
//  UIColor+Exstension.swift
//  BuildSwift
//
//  Created by xc on 2019/8/8.
//  Copyright © 2019 四川隧唐科技股份有限公司. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var HeightLightColor:UIColor{
        return MainPinkColor
    }
    
    
    //渐变颜色配置
    @objc class var DarkBlueColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "DarkBlueColor")!
        }
        return color("#0041CF")
    }
    @nonobjc class var LightBlueColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "LightBlueColor")!
        }
        return color("#83BCFF")
    }
    @nonobjc class var DarkPinkColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "DarkPinkColor")!
        }
        return color("#F53E77")
    }
    @nonobjc class var LightPinkColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "LightPinkColor")!
        }
        return color("#FFCED4")
    }
    @nonobjc class var DarkGreenColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "DarkGreenColor")!
        }
        return color("#10AFB3")
    }
    @nonobjc class var LightGreenColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "LightGreenColor")!
        }
        return color("#68EC98")
    }
    
    
    @nonobjc class var DarkYellowColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "DarkYellowColor")!
        }
        return color("#FF9B21")
    }
    @nonobjc class var LightYellowColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "LightYellowColor")!
        }
        return color("#FFEA9F")
    }
    
    
    @nonobjc class var DarkPurpleColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "DarkPurpleColor")!
        }
        return color("#8169E6")
    }
    @nonobjc class var LightPurpleColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "LightPurpleColor")!
        }
        return color("#C4A1FF")
    }
    
    @nonobjc class var DarkSpeColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "DarkSpeColor")!
        }
        return color("#E9004F")
    }
    @nonobjc class var LightSpeColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "LightSpeColor")!
        }
        return color("#FF8F6A")
    }
    
    
    //viewColor
    @nonobjc class var MainBlueColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "MainBlueColor")!
        }
        return color("#0041CF")
    }
    @nonobjc class var MainPinkColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "MainPinkColor")!
        }
        return color("#FF039C")
    }
    @nonobjc class var SubGreenColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "SubGreenColor")!
        }
        return color("#0FE285")
    }
    @nonobjc class var SubYellowColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "SubYellowColor")!
        }
        return color("#FF9B21")
    }
    
    
    
    @nonobjc class var SubPurpleColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "SubPurpleColor")!
        }
        return color("#9A20FF")
    }
    
    @nonobjc class var SeparatorColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "SeparatorColor")!
        }
        return color("#D1E1F1")
    }
    
    @nonobjc class var NewSeparatorColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "NewSeparatorColor")!
        }
        return color("#E2E8EE")
    }
    
    
    @nonobjc class var BackgroundColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "BackgroundColor")!
        }
        return color("#F0F5FB")
    }
   
    @nonobjc class var DeleteColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "DeleteColor")!
        }
        return color("#F73E68")
    }
    
    @objc class var BgBlueColor: UIColor {
        if #available(iOS 11, *) {
            return UIColor(named: "BgBlueColor")!
        }
        return color("#E5EDFE")
    }
    
    @objc class var BgGreenColor: UIColor {
        if #available(iOS 11, *) {
            return UIColor(named: "BgGreenColor")!
        }
        return color("#E7FCF3")
    }
    
    @objc class var BgRedColor: UIColor {
        if #available(iOS 11, *) {
            return UIColor(named: "BgRedColor")!
        }
        return color("#FFE5F5")
    }
    
    @objc class var BgYellowColor: UIColor {
        if #available(iOS 11, *) {
            return UIColor(named: "BgYellowColor")!
        }
        return color("#FFF5E8")
    }
    
    //文字
    @nonobjc class var TextSubColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "TextSubColor")!
        }
        return color("#999FB0")
    }
    @nonobjc class var TextMainColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "TextMainColor")!
        }
        return color("#131D36")
    }
    @nonobjc class var TextPlaceholderColor: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "TextPlaceholderColor")!
        }
        return color("#C8CEDC")
    }
    
    
    
    /// 十六进制转颜色
    /// - Parameter hexString: 十六进制字符串
    /// - Parameter alpha: 透明度
    @nonobjc class func color(_ hexString: String, alpha: CGFloat = 1) -> UIColor {
        
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}

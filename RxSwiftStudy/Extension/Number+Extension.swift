//
//  Number+Extension.swift
//  Build
//
//  Created by Alan on 2020/6/20.
//  Copyright © 2020 四川隧唐科技股份有限公司. All rights reserved.
//

import Foundation


extension Double{
    ///四舍五入指定位数小数
    func roundTo(places: Int = 2) ->Double{
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Int{
    
    func makeNumberToShow(_ unit:String,needSpace:Bool = true) ->String{
        let newCount = Double(self)
        let space = needSpace ? "  " : ""
        var doublePrice = 0.0
        if self < 10000{
            return "\(self)\(space)\(unit)"
        }else if self < 10000 * 1000{
            doublePrice = Double(newCount / 10000)
            //保留1位小数
            let divisor = pow(10.0, Double(1))
            let value = (doublePrice * divisor).rounded() / divisor
            return "\(value)万\(space)\(unit)"
        }else if self < Int64(10000 * 1000) * 1000{
            doublePrice = Double(newCount / 10000 / 1000)
            //保留1位小数
            let divisor = pow(10.0, Double(1))
            let value = (doublePrice * divisor).rounded() / divisor
            return "\(value)千万\(space)\(unit)"
        }
        return "\(self)\(space)\(unit)"
    }
}

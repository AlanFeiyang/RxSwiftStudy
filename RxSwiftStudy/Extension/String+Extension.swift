//
//  String+Extension.swift
//  BuildSwift
//
//  Created by xc on 2019/8/9.
//  Copyright © 2019 四川隧唐科技股份有限公司. All rights reserved.
//

import Foundation
import CommonCrypto


extension String {
    
    //单行的宽高
    
    ///单行的宽高
    /// - Parameter font: 字号
    func size(_ font: UIFont) -> CGSize {
        
        let size = self.size(withAttributes: [NSAttributedString.Key.font:font])
        
        return size
    }
    
    //高度计算
    func height(_ font:UIFont,size:CGSize) -> CGRect {
    
        let rect = self.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSAttributedString.Key.font:font], context: nil)
        
        return rect
    }
    
    //高度计算
   func height(_ font:UIFont,maxWidth : CGFloat) -> CGFloat {
       
       return self.boundingRect(with: CGSize.init(width: maxWidth, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin], attributes: [.font : font], context: nil).size.height
   }
    
    //带行距的高度计算
    func attributedHeight(_ font:UIFont,size:CGSize,lineSpace:CGFloat) -> CGRect {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.lineBreakMode = .byWordWrapping
        let dict = [NSAttributedString.Key.font:font,
                    NSAttributedString.Key.paragraphStyle:paragraphStyle]
        let rect = self.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: dict, context: nil)
        return rect
    }
    
    //格式化小数
    func decimalNumber(scale: Int = 2) -> NSNumber {
        if Float(self) == 0 {
            return NSNumber(value: 0)
        }
        
        let roundUp = NSDecimalNumberHandler(roundingMode: .plain, scale: Int16(scale), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        
        let number = NSDecimalNumber(string: self)
        let numberPlain = number.rounding(accordingToBehavior: roundUp)
        
        return numberPlain
    }
    
    
    /// 格式化小数
    /// - Parameter scale: 保留位数，默认为两位小数
    func formatting(scale: Int = 2) -> String {
        
        let number = decimalNumber(scale: scale)
        
        return number.stringValue
    }
   
    
    
    //rsa公钥加密
    func encrypt() -> String{
        let cryptString = STRSA.encryptString(self, publicKey: RSA_PUBLICK_KEY)
        return cryptString ?? ""
    }
    
    //rsa私钥解密
    func decrypt() -> String {
        let decryptString = STRSA.decryptString(self, privateKey: RSA_PRIVATE_KEY)
        return decryptString ?? ""
    }
    
    
    //文本内容框架,主要是增加间距
    func makeMutableAttributed(_ alignment:NSTextAlignment = .left) -> NSMutableAttributedString{
        let atts = NSMutableAttributedString(string: self)
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 5
        paraStyle.alignment = alignment
        paraStyle.lineBreakMode = .byTruncatingTail
        
        atts.addAttribute(NSAttributedString.Key.paragraphStyle, value: paraStyle, range: NSRange(location: 0, length: self.utf16.count))
        return atts
    }
    
    
    
    func dateToShow(_ format:DateFormatStyle = .date) ->String{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatStyle.dateWithTime.rawValue
        let formdate = formatter.date(from: self) ?? Date()
        let fromStamp = formdate.timeIntervalSince1970
        let nowDate = Date()
        let nowStamp = nowDate.timeIntervalSince1970
        let time = Int(nowStamp - fromStamp)
        
        let tenMinutes = 60 * 10//十分钟
        let oneHour = 60 * 60 //一小时
        var str = ""
        if time < 0 {
            str = "未到发布时间"
        }else if time < tenMinutes{
            str = "刚刚"
        }else if time >= tenMinutes,time < oneHour{
            str = "10分钟前"
        }else if time <= oneHour * 24{
            let hour = Int(time / oneHour)
            str = "\(hour)小时前"
        }else{
            str = formdate.string(format: format)
        }
        return str
    }
    
    
    func showHTML() -> NSMutableAttributedString?{
        guard let news = self.removingPercentEncoding,let data = news.data(using: .unicode) else{return nil}
        let att = [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html]
        guard let attStr = try? NSMutableAttributedString(data: data, options: att, documentAttributes: nil) else{return nil}
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let range = NSRange(location: 0, length: attStr.length)
        attStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        return attStr
    }

}

extension String {
    
    //手机号验证
    func validatePhoneNumber() -> Bool {
        let mobile = "1(3[0-9]|4[0-9]|5[0-9]|6[0-9]|7[0-9]|8[0-9]|9[0-9])\\d{8}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        return regextestmobile.evaluate(with: self)
    }

}


extension String {
    func ranges(of string: String) -> [Range<String.Index>] {
        var rangeArray = [Range<String.Index>]()
        var searchedRange: Range<String.Index>
        guard let sr = self.range(of: self) else {
            return rangeArray
        }
        searchedRange = sr
        
        var resultRange = self.range(of: string, options: .regularExpression, range: searchedRange, locale: nil)
        while let range = resultRange {
            rangeArray.append(range)
            searchedRange = Range(uncheckedBounds: (range.upperBound, searchedRange.upperBound))
            resultRange = self.range(of: string, options: .regularExpression, range: searchedRange, locale: nil)
        }
        return rangeArray
    }
    
    func nsrange(fromRange range : Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    func nsranges(of string: String) -> [NSRange] {
        return ranges(of: string).map { (range) -> NSRange in
            self.nsrange(fromRange: range)
        }
    }
    
//    ///四舍五入指定位数小数
//    func roundTo(_ price:String, places: Int = 2) ->Double{
//        let doublePrice = Double(self) ?? 0
//        let divisor = pow(10.0, Double(places))
//        return (doublePrice * divisor).rounded() / divisor
//    }
}





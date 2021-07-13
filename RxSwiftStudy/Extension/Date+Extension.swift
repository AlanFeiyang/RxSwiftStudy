//
//  Date+Extension.swift
//  ProjectBuild
//
//  Created by xc on 2019/8/28.
//  Copyright © 2019 四川隧唐科技股份有限公司. All rights reserved.
//





import Foundation

//时间格式化类型
enum DateFormatStyle:String {
    case time = "HH:mm:ss"
    case month = "yyyy-MM"
    case monthA = "yyyy/MM"
    case date = "yyyy-MM-dd"
    case dateWithTime = "yyyy-MM-dd HH:mm:ss"
    case dateC = "yyyy年MM月dd日"
    
    case minutes = "yyyy-MM-dd HH:mm"
    
    case HH = "HH"
    case day = "dd"
    case HH_mm = "HH:mm"
    case MM = "MM"
    case year = "yyyy"
}

extension Date {
    var week: String {
//        let date = Date.date(attend_date, format: .date)
        let weekdayComponents = Calendar.current.dateComponents([.weekday], from: self)
        
        let weekDays = [" ","周日","周一","周二","周三","周四","周五","周六"]
        guard let week = weekdayComponents.weekday else {
            return ""
        }
        return weekDays[week]
        
    }
    /// date 转 string
    /// - Parameter format: 时间格式
    func string(format:DateFormatStyle) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format.rawValue
        let dateString = dateFormat.string(from: self)
        return dateString
    }
        
    /// string 转 date
    /// - Parameter string: 时间字符串
    /// - Parameter format: 时间格式
    static func date(_ string:String, format:DateFormatStyle = .date) -> Date {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format.rawValue
        
        let date = dateFormat.date(from: string)
        
        return date!
    }
        
    /// 计算该月份有多少天
    func dayCount() -> Int {
        guard let monthRange = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: self) else {return 0}
        let count = monthRange.count
        debugPrint(count)
        return count
    }
    
    
    /// 计算一段时间之内的天数
    /// - Parameter fromDate: 起始时间
    /// - Parameter toDate: 结束时间
    static func numberOfdays(fromDate:Date, toDate:Date) -> Int {
        let calendar = Calendar.init(identifier: .gregorian)
        
        let dateComponents = calendar.dateComponents([.day], from: fromDate, to: toDate)
        return dateComponents.day ?? 0
    }
    
        
    /// 计算一段时间之内月的个数
    /// - Parameter fromDate: 起始时间
    /// - Parameter toDate: 结束时间
    static func numberOfMonths(fromDate:Date, toDate:Date) -> Int {
        let calendar = Calendar.init(identifier: .gregorian)
        
        let dateComponents = calendar.dateComponents([.month], from: fromDate, to: toDate)
        return dateComponents.month ?? 0
    }
        
    /// 获取指定时间内的所有日期
    /// - Parameter start: 起始时间
    /// - Parameter end: 结束时间
    static func getDates(start:Date, end:Date) -> [String] {
        
        var from = start
        
        let calendar = Calendar(identifier: .gregorian)
        
        var components = [String]()
        
        var result = from.compare(end)
        
        var comps: DateComponents!
        
        while result != .orderedDescending {
            comps = calendar.dateComponents([.year, .month, .day, .weekday], from: from)
            let startStr = from.string(format: .date)
            components.append(startStr)
            
            //后一天
            comps.day = comps.day! + 1
            
            from = calendar.date(from: comps)!
            
            //对比日期大小
            result = from.compare(end)
        }
        return components
    }
        
    /// 获取指定时间内的所有月份
    /// - Parameter start: 起始时间
    /// - Parameter end: 结束时间
    static func getMonths(start:Date, end:Date) -> [String] {
        var from = start
        
        let calendar = Calendar(identifier: .gregorian)
        
        var components = [String]()
        
        var result = from.compare(end)
        
        var comps: DateComponents!
        
        while result != .orderedDescending {
            comps = calendar.dateComponents([.year, .month], from: from)
            
            let startStr = from.string(format: .month)
            components.append(startStr)
            
            //后一月
            comps.month = comps.month! + 1
            
            from = calendar.date(from: comps)!
            
            //对比日期大小
            result = from.compare(end)
        }
        return components
    }
    
    //获取近几个月[yyyy-MM]
    static func getNearMonth(count: Int = 7) -> [String]{
        
        var from = Date()
        
        let calendar = Calendar(identifier: .gregorian)
        
        var components = [String]()
        var comps: DateComponents!
        for _ in 1..<count {
            comps = calendar.dateComponents([.year, .month], from: from)
            components.append(from.string(format: .month))
            //前一月
            comps.month = comps.month! - 1
            from = calendar.date(from: comps)!
        }
        return components
    }
    
    //获取近几天的日期[yyyy-MM-dd]
    static func getNearDay(count: Int = 7) -> [String] {
        if count <= 0 {
            return []
        }
        var from = Date()
        
        let calendar = Calendar(identifier: .gregorian)
                
        var comps: DateComponents!
        
        var components = [String]()
        
        for _ in 0..<count {
            comps = calendar.dateComponents([.year, .month, .day], from: from)
            
            components.append(from.string(format: .date))
            
            comps.day = comps.day! - 1
            from = calendar.date(from: comps)!
            
        }
//        print(components)
        return components
    }
}

//
//  STLogAPI.swift
//  Build
//
//  Created by Alan on 2020/5/6.
//  Copyright © 2020 四川隧唐科技股份有限公司. All rights reserved.
//

import UIKit

enum STLogAPI {
    ///其他登录
    case SelfLogin(para:[String: Any])
    ///退出登录
    case Logout
    ///登录
    case Login(para:[String: Any])
    ///获取验证码
    case GetLoginSmsCode(para:[String: Any])
    ///验证
    case VerifLoginSmsCode(para:[String: Any])
}

extension STLogAPI:TargetType{
    var path: String {
        switch self {
            
        case .SelfLogin:
            return "SelfLogin"
            
        case .Logout:
            return "Logout"
            
        case .Login:
            return "Login"
            
        case .GetLoginSmsCode:
            return "GetLoginSmsCode"
            
        case .VerifLoginSmsCode:
            return "VerifLoginSmsCode"
        }
    }
       
    var para: [String: Any]{
        switch self {
        case .SelfLogin(let dict):
            return dict
        case .Logout:
            return [:]
        case .Login(let dict):
            return dict
        case .GetLoginSmsCode(let dict):
            return dict
        case .VerifLoginSmsCode(let dict):
            return dict
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .Logout:
            //退出登录才需要userid
             let cryptStr = "userid=\(UserId)&platform=3&dev=\(DeviceInfo)".encrypt()
            return ["Token-Cninct":cryptStr]
        default:
            let cryptStr = "platform=3&dev=\(DeviceInfo)".encrypt()
            return ["Token-Cninct":cryptStr]
        }
    }

    var task: Task {
       
       return .requestParameters(parameters: para, encoding: JSONEncoding.default)
    }
}

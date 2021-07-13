//
//  STUserService.swift
//  Build
//
//  Created by Alan on 2020/5/6.
//  Copyright © 2020 四川隧唐科技股份有限公司. All rights reserved.
//

import UIKit



class STUserService: NSObject {
    static let `default` = STUserService()
    private override init() {}
    //用户信息
    var userModel:STUserInfoModel {
        return readUserInfo() ?? STUserInfoModel()
    }
    
    
}

//个人信息
extension STUserService{
    func saveUserInfo(_ info :STUserInfoModel){
        //解析并存储个人信息
        guard let jsonString = info.toJSON() else{
            debugPrint("UserDefaults存储个人信息失败")
            return
        }
        debugPrint("UserDefaults存储个人信息成功")
        UserDefaults.standard.set(jsonString, forKey: UserInfoKey)
        UserDefaults.standard.synchronize()
    }
    
    //读取个人信息
    func readUserInfo() -> STUserInfoModel?{
        guard let info = UserDefaults.standard.value(forKey: UserInfoKey) as? [String: Any] else{
            debugPrint("读取UserDefaults失败")
            return nil
        }
        guard let model = STUserInfoModel.deserialize(from: info) else{
            debugPrint("字典转模型失败")
            return nil
        }
        return model
 
    }
    
    //移除个人信息
    func removeUserInfo(){
        UserDefaults.standard.removeObject(forKey: UserInfoKey)
        UserDefaults.standard.synchronize()
    }
}

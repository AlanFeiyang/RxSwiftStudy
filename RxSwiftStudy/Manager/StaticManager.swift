//
//  StaticManager.swift
//  BuildSwift
//
//  Created by xc on 2019/8/7.
//  Copyright © 2019 四川隧唐科技股份有限公司. All rights reserved.
//

import Foundation

///Key
let BuglyKey = "0fb4ef933f"
let MapKey = "df5351a938020d2b6abc329f5e5ceca6"
let QQAppID = "1104913875"
let QQAppKey = "fRme9sCs4jpOdUiI"
let WBAppID = "300142938"
let WBAppSecre = "53b1allc71f79d6b04123a10730bec28"
let WXAppID = "wx1a3fe709f4394c57"
let WXAppSecre = "1123650b09b085635ad772b86b1c93ff"
let UniversalLink = "https://news.cninct.com/jjt/"
let QQUniversalLink = "https://news.cninct.com/qq_conn/1104913875"
let UMPushKey = "5ee83d740cafb2d24c00004e"
let Device_Token_Key = "device_token_key"



let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

//第一次启动
let IsFirstLunchKey = "isFirst" + AppVersion
let IsFirstLunch = UserDefaults.standard.object(forKey: IsFirstLunchKey)

//消息推送时间提示
let ShowPushKey = "IsFirstLunchKey"



//未登录,读取本地数据
var IsLogin:Bool{
    return UserId != ""
}

// UserDefaults.standardKey
let UserInfoKey = "UserInfoKey"
let AccountKey = "AccountKey"
//let PasswordKey = "PasswordKey"
let RememberKey = "RememberKey"
let UseridKey = "UseridKey"

//研究报告搜索
let ResearchSearchKey = "ResearchSearchKey"
let ResearchBuySearchKey = "ResearchBuySearchKey"


//设置
let AllowLoadImageKey = "AllowLoadImageKey"
let AllowPlayVideoKey = "AllowPlayVideoKey"

//屏幕宽高
var ScreenSize: CGSize {
    return UIScreen.main.bounds.size
}
var ScreenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}

var IsBigScreen:Bool{
    return ScreenWidth >= 414
}

var ScreenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}

var StatusBarHeight: CGFloat {
    if #available(iOS 13, *) {
        let nowWindow = UIApplication.shared.windows.first
        let statusBarManager = nowWindow?.windowScene?.statusBarManager
        return statusBarManager?.statusBarFrame.size.height ?? 0
    } else {
        return UIApplication.shared.statusBarFrame.size.height
    }
}

let NavBarHeight:CGFloat = 44.0

var TopBarHeight: CGFloat {
    return StatusBarHeight + NavBarHeight
}


let Space:CGFloat = 16


var BottomBarHeight:CGFloat{
    
    var bottom: CGFloat = 49
    if StatusBarHeight == 20 {
        bottom = 56
    }
    return StatusBarHeight == 20 ? bottom :  83
}

var BottomSafeHeight:CGFloat {
    
    let nowWindow = UIApplication.shared.windows.first
    if #available(iOS 11.0, *) {
        return  nowWindow?.safeAreaInsets.bottom ?? 0
    } else {
        return 0
    }

}



//MARK:UserInfo
var UserModel:STUserInfoModel?{
    return STUserService.default.readUserInfo()
}


var UserId:String{
    return UserDefaults.standard.string(forKey: UseridKey) ?? ""
}

var AccountId:Int{
    return STUserService.default.userModel.account_id
}

var AccountName:String{
    return STUserService.default.userModel.account_name
}

var AccountPic:String{
    return STUserService.default.userModel.account_pic
}

var AllowLoadImage:Bool{
    let allowLoadImage = UserDefaults.standard.bool(forKey: AllowLoadImageKey)
    return allowLoadImage
}

var AllowPlayVideo:Bool{
    return UserDefaults.standard.bool(forKey: AllowPlayVideoKey)
}



var DeviceInfo: String {
    
    let PhoneType = DeviceName
    let SystemVersion = UIDevice.current.systemVersion
    return  "AV:" +  AppVersion + ",PT:" + PhoneType + ",SV:" + SystemVersion
}


let DevUrl = "https://std.cninct.com/JiJianTong_DEV"
let DisUrl = "https://news.cninct.com/JiJianTong"

var NowUrl:String{

    #if DEBUG
    return DevUrl
//    return DisUrl
    #else
    return DisUrl
    #endif
}


//建筑定制用户协议
let BuildProtocolUrl = "\(NowUrl)/html/customization.html"
//普通用户协议
let NormalProtocolUrl = "\(NowUrl)/html/agreement.html"
//隐私协议
let PravityProtocolUrl = "\(NowUrl)/MOULD/pricacy.html"

var BaseUrl: String {
    
    //正式：https://news.cninct.com/JiJianTong/html/manage/
    //测试：
    let baseUrl = "\(NowUrl)?op="
    return baseUrl
}


var RSA_PUBLICK_KEY: String {
    return "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCNkKNoYNo3WC6wEvZIXoW00GRuYiI9o6osjtXd79VnKuPnbcTfSQi+Gg2dSYWpkNqs90c3+tQ6yyM/U0HkWo1B5eTVeJw18tcygRryOgrsqLnaTOGsLAgJ2rV8mhRfpRNtVR+b18GrddSPmVXOYPMpXXGP0Cz5GhZBu6nQ+eB7ZwIDAQAB"
}

var RSA_PRIVATE_KEY: String {
    return "MIICXAIBAAKBgQDWjQ40khNP1nfkXbvI15sNEJkJ0thHiFbD6uOdPdvMb2SzMykU1dZbZksWy57Nd/GnUEYf0pf59yTA0SJTWIScBt5BOTUpWqJwVGbWxpzpajEfPDg8lsSighRhYoGjPkSOscr4GBYlnrRaDaUJd8Ali8P0BoXgScgBEyJZ/eZznQIDAQABAoGAIQdb/XnTYUIJ+Oz5IKUYaH16ocmEpBZ4DPcXDTjdom4vmWqx01RMCIwJ2TuFeeoSGIjCEtoPrVp/nPNVDnGdEEONltEE6kFB52K8lyLuBaKYsID40lMhCG45HsrptxVYJiiCcbGtvy/YjZkXuh46ZDsKbpp/X7XGIouKRKyakoECQQD/azNBzYfu7jzuED8/kljD8hHzMRcnxCvuXYgxI6GmTDTfaqPAPIvF45tkkfovp8lq2GoShRczm++0VOdX1Y69AkEA1woL/0cRi3flOybqxFdbuoMT1yPwOaf+oHamv4aa4KLGwwJ3Gkf05liwNMbBFF6ieu5JzxwOtacZXxYdMRW2YQJAf6sfxcZsKbufbQdl9eq6v8ahvkNNZa0ioFTUHGvJAwyYaQwuqYoZ+2IXbB+jRGrDvMpLytIHlN5e5G6D7F1sqQJBAJzAkSBEEREGlA37f3UibRZXiHXyl6GfyWf1NfY1S97mKVdsC6AXxfjHu6KtI4ASwAQ2gY082agnJ8J9n0fxmOECQCkUhjlcyyYEg1zE5UhGuZCGD1kJwN3hvG9HlNzP+AuH7kRcQzHm/n/5MCMf/joQ+ljMjpRvi5l+vzwnFAEgqHI="
}


let AES_Key = "cninct123456789"

//图片压缩大小限制
let ImageDataSizeLimited: CGFloat = 524288


///Cinct图
let CoverHoldImage = UIImage(named: "icon_home_img_default")
///带头盔的默认头像
let HeaderHoldImage = UIImage(named: "btn_profile_default")
//作者背景图
let BgViewHoldImage = UIImage(named: "bg_writer_default")



enum STRefreshStatus {
    case none
    case beingHeaderRefresh
    case beingFooterRefresh
    case endRefresh
    case noMoreData
}


enum ModuleName:String {
    case Account = "Account"
    case Suggestion = "Suggestion"
    case OrderDesign = "OrderDesign"
}
//1:单页面
//2:订阅须知
//3:关于我们
//4:隐私政策
//8:高端数据
//9:竞争分析
//10:数据分析

enum SinglePage:Int{
    case singlePage = 1
    case subscibe = 2
    case about = 3
    case privacy = 4
    case highData = 8
    case competitiveData = 9
    case dataAnalysis = 10
}


enum PayType:Int {
    case Report//研究报告
    case Design//建筑定制
    case Application//应用
}




let VideoReloadAction = NSNotification.Name.init("VideoReloadAction")

//NotificationName
///微信支付成功NotificationName
let WeChatPaySuccess = NSNotification.Name.init("WeChatPaySuccess")
let AliPaySuccess = NSNotification.Name.init("AliPaySuccess")


let LoginSuccess = NSNotification.Name.init("LoginSuccess")
let LogoutSuccess = NSNotification.Name.init("LogoutSuccess")



///获取App版本
var AppVersion:String{
    if let dict = Bundle.main.infoDictionary{
        return dict["CFBundleShortVersionString"] as? String ?? ""
    }
    return ""
}

///获取App名称
var AppName:String{
   if let dict = Bundle.main.infoDictionary{
        return dict["CFBundleExecutable"] as? String ?? ""
    }
    return ""
}

///获取设备型号
var DeviceName:String{
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    switch identifier {
    case "iPod5,1":                                 return "iPodTouch5"
    case "iPod7,1":                                 return "iPodTouch6"
    case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone4"
    case "iPhone4,1":                               return "iPhone4s"
    case "iPhone5,1", "iPhone5,2":                  return "iPhone5"
    case "iPhone5,3", "iPhone5,4":                  return "iPhone5c"
    case "iPhone6,1", "iPhone6,2":                  return "iPhone5s"
    case "iPhone7,2":                               return "iPhone6"
    case "iPhone7,1":                               return "iPhone6Plus"
    case "iPhone8,1":                               return "iPhone6s"
    case "iPhone8,2":                               return "iPhone6sPlus"
    case "iPhone9,1":                               return "iPhone7(CDMA)"
    case "iPhone9,3":                               return "iPhone7(GSM)"
    case "iPhone9,2":                               return "iPhone7Plus(CDMA)"
    case "iPhone9,4":                               return "iPhone7Plus(GSM)"
    case "iPhone10,1","iPhone10,4":                 return "iPhone8"
    case "iPhone10,2","iPhone10,5":                 return "iPhone8Plus"
    case "iPhone10,3","iPhone10,6":                 return "iPhoneX"
    case "iPhone11.8":                              return "iPhoneXR"
    case "iPhone11.2":                              return "iPhoneXS"
    case "iPhone11,3","iPhone11,6":                 return "iPhoneXSMax"
    case "iPhone12,1":                              return "iPhone11"
    case "iPhone12,3":                              return "iPhone11Pro"
    case "iPhone12,5":                              return "iPhone11ProMax"
    case "iPhone12,8":                              return "iPhoneSE2"
    case "iPhone13,1":                              return "iPhone12Mini"
    case "iPhone13,2":                              return "iPhone12"
    case "iPhone13,3":                              return "iPhone12Pro"
    case "iPhone13,4":                              return "iPhone12ProMax"
        
        
    
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad2"
    case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad3"
    case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad4"
    case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPadAir"
    case "iPad5,3", "iPad5,4":                      return "iPadAir2"
    case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPadMini"
    case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPadMini2"
    case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPadMini3"
    case "iPad5,1", "iPad5,2":                      return "iPadMini4"
    case "iPad6,7", "iPad6,8":                      return "iPadPro"
    case "AppleTV5,3":                              return "AppleTV"
    case "i386", "x86_64":                          return "Simulator"
    default:                                        return identifier
    }
}




let NoMessageStr = "你很低调,一条消息都没有~"
let NoBrowseStr = "精彩那么多,你却没留下脚步.."
let NoReportStr = "快去网页端发布你的第一条资讯吧!"
let NoCollectArtilceStr = "快去收藏自己喜欢的文章吧!"
let NoCollectVideoStr = "快去收藏自己喜欢的视频吧!"
let NoFocusStr = "这里好冷,什么也没有~"
let NoFansStr = "这么优秀的人居然没粉丝~"
let NoOrderStr = "还没有定制的内容呢~"
let NoRecommendStr = "精彩那么多,不值得推荐一下?"



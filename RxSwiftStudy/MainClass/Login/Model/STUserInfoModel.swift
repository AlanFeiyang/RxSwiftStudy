//
//  STUserInfoModel.swift
//  Build
//
//  Created by Alan on 2020/5/6.
//  Copyright © 2020 四川隧唐科技股份有限公司. All rights reserved.
//

import UIKit

class STUserInfoModel: STBaseModel {
    var account_id = 0 // 自增长账户id
    var account_type = 0 //账号类型, 1普通用户, 2专栏作者, 3内部管理员, 4企业用户
    var account = "" // 账号
    var account_name = "" // 姓名
    var account_pic = "" // 账户图片
    var account_password = "" // 密码
    var identity_card_num = "" // 身份证号码
    var identity_card_pic = "" // 身份证图片
    var phone_num = "" // 电话号码
    var account_status = 0 // 人员状态：1在职 2离职
    var staff_status = 0 // 账号状态,1:正常,2:隐藏,3:删除，4：禁用
    var userid = ""
    var account_birth_day = "" // 生日
    var account_job = "" // 所属行业
    var account_live_at = "" // 所在地
    var account_location = "" // 所在地址
    var account_location_lat = "" // 地址-纬度
    var account_location_lng = "" // 地址-经度
    var account_mail = "" // 邮箱
    var account_mail_verification = 0 // 邮箱认证 1:未认证 2:已认证
    var account_nick_name = "" // 昵称
    var account_phone_time:TimeInterval = 0 // 最后一次更换手机号码的时间（时间戳）
    
    var account_register_apple_token = "" // apple的token
    var account_register_qq_token = "" // QQ的token
    var account_register_time = "" // 注册时间
    var account_register_type = 0
    var account_register_wx_token = "" // WX的token
    
    var account_self_authentication = "" // 个人认证
    var account_self_desc = "" // 个人简介
    var gender = 0 // 性别:1男, 2女
    var background_pic = "" // 用户背景图片
//    var account_pic_url = "" // 头像图片url
    var account_publish_count = 0//人员-发布数
    var account_fan_count = 0//人员-粉丝数
    var account_be_fan_count = 0//人员-关注数
    var account_prise_count = 0//人员-获推次数
    var account_background_pic_url = "" // 背景图片url
    var pic_url = "" // 头像url
    
    var qqHeader_url = "" // QQ头像
    var wechatHeader_url = "" // 微信头像

}

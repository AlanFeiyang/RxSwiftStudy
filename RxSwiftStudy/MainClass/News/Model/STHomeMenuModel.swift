//
//  STHomeMenuModel.swift
//  Build
//
//  Created by Alan on 2020/5/7.
//  Copyright © 2020 四川隧唐科技股份有限公司. All rights reserved.
//

import UIKit

class STHomeMenuModel: STBaseModel {
    var label_id = 0//订阅标签id
    var label_name = ""//标签名称
    var label_type = 0//-1固定类型 标签类型, 1普通栏目, 2地方栏目, 3企业栏目
    var label_status = 0//标签状态
    var label_order = 0//排序
    var isSubscribe = false //是否订阅
    var menu_or_label = 2//是否固定 1固定 2不固定
    var isSelected = false//是否选中
    
}


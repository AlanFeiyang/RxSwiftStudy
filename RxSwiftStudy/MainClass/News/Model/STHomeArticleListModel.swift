//
//  STHomeArticleListModel.swift
//  Build
//
//  Created by Alan on 2020/5/8.
//  Copyright © 2020 四川隧唐科技股份有限公司. All rights reserved.
//

import UIKit
import RxDataSources

struct STSection {
    var items:[Item]
}

extension STSection: SectionModelType {
    
    typealias Item = STHomeNewsListModel
    
    init(original: STSection, items: [STSection.Item]) {
        self = original
        self.items = items
    }
}



class STHomeNewsListModel: STBaseModel {
    var article_id = 0//文章id
    var account_id_union = 0//账户id
    var article_prise_id = 0
    var reviewer_id_union = 0//审核人id
    var article_type = 0//文章类型, 1文章, 2视频新闻, 3研究报告
    var is_custom = 0 //是否建筑定制, 1是, 2否
    var title = ""//文章标题
    var title_page_pic_type = 0//文章封面图片类型, 1单图, 2三图, 3无封面
    var title_page_pic = ""//文章封面图片
    var lecture_type = 0//研究报告类型, 1期刊, 2行业
    var lecture_kind = 0//研究报告分类, 101月报, 102季报, 103半年报, 104年报, 201公路, 202铁路, 203轨道交通, 204生态环保
    var summary = ""//文章摘要
    var content = ""//文章正文
    var video = ""//文章视频
    var appendix = ""//文章附件
    var source = ""//文章来源
    var publish_time = ""//发表时间
    var review_time = ""//审核时间
    var review_date_mark = 0//文章状态, 1草稿, 2待审核, 3审核通过/已发布, 4审核未通过/待修改, 5已下架/隐藏
    var article_order = 0
    var article_extra_status = 0//附加状态, 9首推, 8话题, 7热门
    var article_deleted = 0//是否删除, 1是, 2否
    
    var video_duration = ""//文章视频时长
    var account_name = ""
    var view_total = 0//浏览量
    var comment_count = 0//评论量
    var prise_count = 0//推荐量
    var subscribed = 0//是否已关注, 1是, 2否
    var prised = 0//是否已推, 1是, 2否
    var bookmarked = 0//是否已收藏, 1是, 2否
    var avatar_file = ""//头像
    var content_url = ""
    var title_page_pic_files = [String]()//封面图片文件
    var video_files = [String]()//视频文件
    var share_url = ""
    var videoUrl:String{
        if let url = video_files.first,url != ""{
            return url
        }else{
            return external_link
        }
    }
    
    var signature = ""//署名
    var custom_price = ""
    var account_pic_file = ""//头像url
    var account_self_authentication = ""//认证
    var favorite_count = 0//收藏数量//订阅
    var dislike_count = 0//不喜欢
    var account_nick_name = ""//昵称
    var external_link = ""//外部链接
    
    var view_count = 0//是否已读
    
    var imageSize:CGSize{
        let width = (ScreenWidth - Space * 4) / 3
        let height:CGFloat = 80
        return CGSize(width: width, height: height)
    }
}


class STHomeArticleDetailModel: STBaseModel {
    var article_id = 0//文章id
    var account_id_union = 0//账户id
    
    var reviewer_id_union = 0//审核人id
    var article_type = 0//文章类型, 1文章, 2视频新闻, 3研究报告
    var title = ""//文章标题
    var title_page_pic_type = 0//文章封面图片类型, 1单图, 2三图, 3无封面
    var title_page_pic = ""//文章封面图片
    var lecture_type = 0//研究报告类型, 1期刊, 2行业
    var lecture_kind = 0//研究报告分类, 101月报, 102季报, 103半年报, 104年报, 201公路, 202铁路, 203轨道交通, 204生态环保
    var content = ""//文章正文
    var video = ""//文章视频
    var appendix = ""//文章附件
    var source = ""//文章来源
    var publish_time = ""//发表时间
    var review_time = ""//审核时间
    var review_date_mark = 0//文章状态, 1草稿, 2待审核, 3审核通过/已发布, 4审核未通过/待修改, 5已下架/隐藏
    var article_deleted = 0//是否删除, 1是, 2否
    var account_name = ""
    var view_total = 0//浏览量
    var prise_count = 0//推荐量
    var avatar_file = ""//头像
    var title_page_pic_files = [String]()//封面图片文件
    var video_files = [String]()//视频文件
    var videoUrl:String{
        if let url = video_files.first,url != ""{
            return url
        }else{
            return external_link
        }
    }
    
    
    var creation_labels = [STHomeMenuModel]()
    var subscribed = 0//是否已关注, 1是, 2否
    var prised = 0//是否已推, 1是, 2否
    var bookmarked = 0//是否已收藏, 1是, 2否
    var viewer_avatar_files = [String]()//访客集合
    var content_url = ""//webURL
    var share_url = ""//分享
//    var comment_count = 0
    var signature = ""//署名
    var summary = ""//摘要
    var external_link = ""//外部链接
    var article_extra_status = 0
    var custom_price = ""//参考价格
    var account_nick_name = ""
    var view_count = 0//是否已读
}



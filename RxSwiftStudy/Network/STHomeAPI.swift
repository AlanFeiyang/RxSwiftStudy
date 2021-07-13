//
//  STHomeAPI.swift
//  RxSwiftStudy
//
//  Created by Alan on 2021/2/5.
//

import UIKit


enum STHomeAPI {
    //查询文章列表
    case QueryLabelArticle(para:[String: Any])
}

extension STHomeAPI:TargetType{
    var path: String {
        switch self {
        case .QueryLabelArticle:
            return "QueryLabelArticle"
        }
    }
       
    var para: [String: Any]{
        switch self {
        case .QueryLabelArticle(let dict):
            return dict
        }
    }
    
    var task: Task {
       
       return .requestParameters(parameters: para, encoding: JSONEncoding.default)
    }
    
}

//
//  UIScrollView+Extension.swift
//  ProjectBuild
//
//  Created by xc on 2019/9/17.
//  Copyright © 2019 四川隧唐科技股份有限公司. All rights reserved.
//

import Foundation

var requestDataSourceKey = "requestDataSourceKey"
var requestPageKey = "requestPageKey"
var requestSelectorKey = "requestSelectorKey"
var refreshTargetKey = "refreshTargetKey"

extension UIScrollView {
    
    private weak var refreshTarget: AnyObject?{
        set {
            
            objc_setAssociatedObject(self, &refreshTargetKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        
        get {
            return objc_getAssociatedObject(self, &refreshTargetKey) as AnyObject
        }
    }
    
    private var requestSelector: String? {
        set {
            objc_setAssociatedObject(self, &requestSelectorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            
            return objc_getAssociatedObject(self, &requestSelectorKey) as? String
        }
    }
    
    
    var dataArray: [Any]{
        
        set {
            objc_setAssociatedObject(self, &requestDataSourceKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            guard let requestDataSources = objc_getAssociatedObject(self, &requestDataSourceKey) as? [Any] else {
                
                let requestDataSources = [Any]()
                
                objc_setAssociatedObject(self, &requestDataSourceKey, requestDataSources, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return requestDataSources
            }
            
            return requestDataSources
            
        }
    }
    
    var page: Int {
        set {
            objc_setAssociatedObject(self, &requestPageKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        
        get {
            if let page = objc_getAssociatedObject(self, &requestPageKey) as? Int {
                return page
            }
            
            let page = 0
            objc_setAssociatedObject(self, &requestPageKey, page, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            
            return page
        }
    }
    
    
    
    
    //MARK: - 成功或者失败回调
    func successAction(_ objcts: [Any]) {
        
        if page == 0 {
            dataArray.removeAll()
            objcts.forEach { (item) in
                dataArray.append(item)
            }
            
            if mj_header != nil {
                mj_header?.endRefreshing()
                
            }
            
            if mj_footer != nil {
                mj_footer?.resetNoMoreData()
            }
            
        }else{
            if objcts.count == 0 {
                if mj_footer != nil {
                    mj_footer?.endRefreshingWithNoMoreData()
                }
                
            }else{
                objcts.forEach { (item) in
                    dataArray.append(item)
                }
                if mj_footer != nil {
                    mj_footer?.endRefreshing()
                }
            }
        }
    }
    
    func failureAction(_ errorMessage: String = ""){
        debugPrint(errorMessage)
        
        if page > 0 {
            page -= 1
        }
        
        if mj_header != nil {
            mj_header?.endRefreshing()
        }
        
        if mj_footer != nil {
            mj_footer?.endRefreshing()
        }
    }
    
    func addRefresh() {
        
    }
    
    func addScrollViewRefresh(target: AnyObject, request selector: Selector){
        addScrollViewHeaderRefresh(target: target, request: selector)
        addScrollViewFooterRefresh(target: target, request: selector)
    }
    
    func addScrollViewHeaderRefresh(target:AnyObject, request selector: Selector){
        if (refreshTarget?.isKind(of: NSNull.self))! {
            refreshTarget = target
        }
        if requestSelector == nil {
            requestSelector = NSStringFromSelector(selector)
        }
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerScrollViewRefresh))
        mj_header = header
    }
    
    func addScrollViewFooterRefresh(target:AnyObject, request selector: Selector){
        page = 0
        if (refreshTarget?.isKind(of: NSNull.self))! {
            refreshTarget = target
        }
        if requestSelector == nil {
            requestSelector = NSStringFromSelector(selector)
        }
        
        mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerScrollViewRefresh))
    }
    
    func beginScrollViewRefresh(){
        mj_header?.beginRefreshing()
    }
    
    @objc private func headerScrollViewRefresh(){
        page = 0
        let selector = NSSelectorFromString(requestSelector!)
        print(selector)
        
        if refreshTarget!.responds(to: NSSelectorFromString(requestSelector!)) {
            _ = refreshTarget!.perform(NSSelectorFromString(requestSelector!))
        }
    }
    
    @objc private func footerScrollViewRefresh(){
        page += 1
        if refreshTarget!.responds(to: NSSelectorFromString(requestSelector!)) {
            
            _ = refreshTarget!.perform(NSSelectorFromString(requestSelector!))
        }
    }
    
}



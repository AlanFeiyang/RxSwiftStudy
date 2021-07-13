//
//  STHotNewsListViewModel.swift
//  RxSwiftStudy
//
//  Created by Alan on 2021/6/21.
//

import Foundation

class STHotNewsListViewModel: STViewModelType {
    
    var dataSource = BehaviorRelay<[STHomeNewsListModel]>(value: [])
    
    var page = 0
    
    let provider = NetworkAPI<STHomeAPI>.provider()
    
    typealias Input = STInput
    
    typealias Output = STOutput
    
    struct STInput {
 
    }
    
    struct STOutput {
        let sections: Driver<[STSection]>
        
        let isReload = PublishSubject<Bool>()
        
        let refreshState = BehaviorSubject<MJRefreshAction>(value: .stopLoadmore)
        
        init(sections:Driver<[STSection]>) {
            self.sections = sections
        }
    }
    
    func transform(input: STInput) -> STOutput {
        let sections = dataSource.asObservable().map { (models) in
            return [STSection(items: models)]
        }.asDriver(onErrorJustReturn: [])
        
        let output = STOutput(sections: sections)
        
        output.isReload.subscribe { [weak self] isReload in
            guard let self = self else{return}
            self.page = isReload ? 0 : self.page + 1
            self.queryNetworkData()
                .subscribeOn(MainScheduler.asyncInstance)
                .subscribe { array in
                    
                    if isReload{
                        self.dataSource.accept(array)
                        output.refreshState.onNext(.stopRefresh)
                    }else{
                        
                        if array.isEmpty {
                            output.refreshState.onNext(.showNomoreData)
                        }else{
                            output.refreshState.onNext(.stopLoadmore)
                        }
                        self.dataSource.append(contentsOf: array)
                    }
                } onError: { error in
                    if isReload{
                        output.refreshState.onNext(.stopRefresh)
                    }else{
                        output.refreshState.onNext(.stopLoadmore)
                    }
                }.disposed(by: disposed)
        } onError: { error in
            
        } onCompleted: {
            
        }.disposed(by: disposed)


        return output
    }
    
    func queryNetworkData()  -> Single<[STHomeNewsListModel]>{
        let dict = ["page": page,
                    "page_size": 5] as [String: Any]
        
        return provider.rx.request(.QueryLabelArticle(para: dict), callbackQueue: .main)
            .asObservable()
            .mapArray(type: STHomeNewsListModel.self)
            .asSingle()
        
    }
    
}

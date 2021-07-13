//
//  STViewModelType.swift
//  RxSwiftStudy
//
//  Created by Alan on 2021/4/26.
//

import Foundation


protocol STViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

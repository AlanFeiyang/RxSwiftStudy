//
//  STLoginVC.swift
//  RxSwiftStudy
//
//  Created by Alan on 2021/6/22.
//

import UIKit
import RxSwift


class STLoginVC: UIViewController {
    @IBOutlet weak var account: UITextField!
    
    var model = STUserInfoModel()
    
    
    var callback:((_ model:STUserInfoModel)->())?
    
    lazy var backButton = UIButton(type: .custom).then {
        $0.frame = CGRect(x: 0, y: 0, width: 80, height: 44)
        $0.setTitle("返回", for: .normal)
        $0.rx.tap.bind { [weak self] _ in
            guard let self = self else{return}
            self.navigationController?.popViewController(animated: true)
            self.callback?(self.model)
        }.disposed(by: disposed)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }

    func setupSubviews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let accountStr = BehaviorRelay(value: model.account)
        let _ = account.rx.textInput <-> accountStr
        accountStr.asObservable()
            .subscribe(onNext:  { [weak self] str in
            guard let self = self else{return}
            self.model.account = str
            print("当前accout",str)
        }).disposed(by: disposed)
    }


}

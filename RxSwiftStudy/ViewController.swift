//
//  ViewController.swift
//  RxSwiftStudy
//
//  Created by Alan on 2021/2/1.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func goAction(_ sender: Any) {
        let vc = STHotNewsListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goLoginVC(_ sender: Any) {
        let vc = STLoginVC()
        let model = STUserInfoModel()
        model.account = "王飞扬"
        vc.model = model
        vc.callback = { [weak self] model in
            guard let self = self else {return}
            print("打印当前accout",model.account)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}


//
//  STHotNewsListViewController.swift
//  RxSwiftStudy
//
//  Created by Alan on 2021/2/7.
//

import UIKit
import Then
import SnapKit
import RxDataSources

class STHotNewsListViewController: UIViewController {
    
    lazy var tableView = UITableView().then {
        $0.register(STHotNewsListTableViewCell.self, forCellReuseIdentifier: "STHotNewsListTableViewCell")
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.tableFooterView = UIView()
//        $0.rowHeight = 44
    }
    
    let dataSource = RxTableViewSectionedReloadDataSource<STSection>(configureCell: { ds, tv, ip, item in
        let cell = tv.dequeueReusableCell(withIdentifier: "STHotNewsListTableViewCell", for: ip) as! STHotNewsListTableViewCell
        cell.model = item
//        let cell = tv.dequeueReusableCell(withIdentifier: "cell")!
//        cell.textLabel?.text = item.title
        return cell
    })
    
    let viewModel = STHotNewsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindViewModel()
    }
    
    func bindViewModel() {
        
        
        let input = STHotNewsListViewModel.Input()
        let output = viewModel.transform(input: input)
        output.sections.asDriver()
            .drive(tableView.rx.items(dataSource:dataSource))
            .disposed(by: disposed)
        
        output.refreshState
            .bind(to: tableView.rx.refreshAction)
            .disposed(by: disposed)
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            output.isReload.onNext(true)
        })
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            output.isReload.onNext(false)
        })
        
        tableView.mj_header?.beginRefreshing()
    }
    
    func setupSubviews() {
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(TopBarHeight)
            make.left.right.equalTo(0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }

        
        
        
 
    }
}





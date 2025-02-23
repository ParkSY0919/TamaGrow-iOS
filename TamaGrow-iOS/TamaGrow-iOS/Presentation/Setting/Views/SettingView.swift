//
//  SettingView.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/24/25.
//

import UIKit

import SnapKit
import Then

final class SettingView: BaseView {
    
    let tableView = UITableView()
    
    override func setHierarchy() {
        self.addSubview(tableView)
        
    }
    
    override func setLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func setStyle() {
        tableView.do {
            $0.rowHeight = 55
            $0.separatorStyle = .singleLine
            $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.register(SettingCell.self, forCellReuseIdentifier: SettingCell.cellIdentifier)
        }
    }
}

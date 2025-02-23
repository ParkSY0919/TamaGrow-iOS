//
//  SettingViewController.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/24/25.
//

import UIKit

import RxCocoa
import RxSwift

final class SettingViewController: BaseViewController {
    
    private let viewModel: SettingViewModel
    private let disposeBag = DisposeBag()
    
    private let mainView = SettingView()
    
    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
        
        super.init(navTitle: "설정", navBtnType: .left(.pop))
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bind()
    }
    
}

private extension SettingViewController {
    
    func bind() {
        let input = SettingViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.settingCellItems
            .bind(to: mainView.tableView.rx.items(cellIdentifier: SettingCell.cellIdentifier, cellType: SettingCell.self)) { row, model, cell in
                cell.backgroundColor = UIColor.bg
                cell.selectionStyle = .none
                cell.configureSettingCell(model: model)
            }
            .disposed(by: disposeBag)
    }
    
}

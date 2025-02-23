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
    private var disposeBag = DisposeBag()
    
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
        
        //닉네임 변경 시 이를 나타내야 하기에 bind를 willAppear에 사용
          //pop으로 돌아왔을 때에 collectionView delegate, datasource 등이 남아있어 disposeBag 초기화도 병행
        disposeBag = DisposeBag()
        bind()
    }
    
}

private extension SettingViewController {
    
    func bind() {
        let input = SettingViewModel.Input(tableViewSelected: mainView.tableView.rx.itemSelected)
        let output = viewModel.transform(input: input)
        
        output.tableViewSelectedRow
            .subscribe(with: self) { owner, row in
                switch row {
                case 0:
                    print("0")
                case 1:
                    print("1")
                    owner.changeTamaTypeCell()
                case 2:
                    owner.resetTypeCell()
                default:
                    print("")
                }
            }.disposed(by: disposeBag)
        
        output.settingCellItems
            .bind(to: mainView.tableView.rx.items(cellIdentifier: SettingCell.cellIdentifier, cellType: SettingCell.self)) { row, model, cell in
                cell.backgroundColor = UIColor.bg
                cell.selectionStyle = .none
                cell.configureSettingCell(model: model)
            }
            .disposed(by: disposeBag)
    }
    
    func changeTamaTypeCell() {
        let vc = EditNicknameViewController(viewModel: EditNicknameViewModel())
        viewTransition(viewController: vc, transitionStyle: .push)
    }
    
    func resetTypeCell() {
        let alert = UIAlertManager.showAlertWithAction(
            title: "데이터 초기화",
            message: "정말 다시 처음부터 시작하실 겁니까?!",
            cancelFunc: true,
            doneAction: UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
                guard let self else {return}
                
                UserDefaultsManager.Key.allCases.forEach {
                    UserDefaults.standard.removeObject(forKey: $0.rawValue)
                }
                UserDefaultsManager.isOnboarding = true
                UserDefaultsManager.tamaType = TamaType.none.rawValue
                UserDefaultsManager.nickname = "대장"
                UserDefaultsManager.level = 1
                UserDefaultsManager.rice = 0
                UserDefaultsManager.water = 0
                
                viewTransition(viewController: OnboardingViewController(), transitionStyle: .resetRootVCwithNav)
            })
        )
        self.present(alert, animated: true)
    }
    
}

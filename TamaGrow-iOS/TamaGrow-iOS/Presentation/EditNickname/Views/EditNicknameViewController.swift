//
//  EditNicknameViewController.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/24/25.
//

import UIKit

import RxCocoa
import RxSwift

final class EditNicknameViewController: BaseViewController {
    
    private let viewModel: EditNicknameViewModel
    private let mainView = SelectedTamaView()
    private let disposeBag = DisposeBag()
    
    private let selectedIndex = PublishSubject<Int>()
    
    override func loadView() {
        view = mainView
    }
    
    init(viewModel: EditNicknameViewModel) {
        self.viewModel = viewModel
        
        super.init(navTitle: "다마고치 변경하기")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func popBtnTapped() {
        super.popBtnTapped()
    }
    
    private func bind() {
        let input = EditNicknameViewModel.Input(selectedIndex: selectedIndex)
        let output = viewModel.transform(input: input)
        
        output.items
            .drive(
                mainView.collectionView.rx.items(cellIdentifier: SelectedTamaCell.cellIdentifier,
                                                 cellType: SelectedTamaCell.self)
            ) { item, model, cell in
                cell.configureTamaView(image: model.image, name: model.name)
            }.disposed(by: disposeBag)
        
        // 아이템 선택 시 인덱스랑 같이 이벤트 발생
        // 인덱스만 전달하고 있으니 cell에 추가로 disposeBag 사용하지 않아도 됨.
        mainView.collectionView.rx.itemSelected
            .map { $0.item }
            .bind(to: selectedIndex)
            .disposed(by: disposeBag)
        
        // 선택된 다마고치 정보 받고 화면 전환
        output.selectedTama
            .subscribe(with: self, onNext: { owner, model in
                let nextViewModel = OnboardingDetailViewModel(
                    leftBtnTitle: StringLiterals.System.cancel,
                    rightBtnTitle: StringLiterals.System.change,
                    tamaImage: model.image,
                    tamaName: model.name
                )
                let vc = OnboardingDetailViewController(viewModel: nextViewModel)
                owner.viewTransition(viewController: vc, transitionStyle: .overCurrentContext)
            })
            .disposed(by: disposeBag)
    }
}

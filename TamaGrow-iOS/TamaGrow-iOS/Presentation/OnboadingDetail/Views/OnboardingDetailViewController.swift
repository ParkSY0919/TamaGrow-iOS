//
//  OnboardingDetailViewController.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

import RxCocoa
import RxSwift

final class OnboardingDetailViewController: BaseViewController {
    
    //MARK: - Properties
    private let viewModel: OnboardingDetailViewModel
    private let disposeBag = DisposeBag()
    
    
    //MARK: - UI Properties
    private lazy var mainView = SelectedTamaPopupView(
        leftBtnTitle: viewModel.leftBtnTitle,
        rightBtnTitle: viewModel.rightBtnTitle,
        tamaImage: viewModel.tamaImage,
        tamaName: viewModel.tamaName
    )
    
    
    //MARK: - Init
    init(viewModel: OnboardingDetailViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
}

private extension OnboardingDetailViewController {
    
    func bind() {
        let input = OnboardingDetailViewModel.Input(
            navLeftBtnTapped: mainView.leftBtn.rx.tap,
            navRightBtnTapped: mainView.rightBtn.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.navLeftBtnTapped
            .drive(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }.disposed(by: disposeBag)
        
        output.navRightBtnTapped
            .drive(with: self) { owner, _ in
                let vc = MainViewController(viewModel: MainViewModel())
                owner.viewTransition(viewController: vc, transitionStyle: .resetRootVCwithNav)
            }.disposed(by: disposeBag)
    }
    
}

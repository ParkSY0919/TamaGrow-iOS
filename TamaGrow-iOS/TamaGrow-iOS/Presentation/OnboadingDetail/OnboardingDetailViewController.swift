//
//  OnboardingDetailViewController.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

final class OnboardingDetailViewController: BaseViewController {
    
    //MARK: - Properties
    private let viewModel: OnboardingDetailViewModel
    
    
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
        
        setAddTarget()
    }
    
}

private extension OnboardingDetailViewController {
    
    func setAddTarget() {
        mainView.leftBtn.addTarget(self, action: #selector(leftBtnTapped), for: .touchUpInside)
        mainView.rightBtn.addTarget(self, action: #selector(rightBtnTapped), for: .touchUpInside)
    }
    
    @objc func leftBtnTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func rightBtnTapped() {
        print(#function)
        UserDefaultsManager.isOnboarding = false
        for i in TamaType.allCases {
            if i.rawValue == viewModel.tamaName {
                UserDefaultsManager.tamaType = i.rawValue
            }
        }
        let vc = MainViewController(navTitle: "\(UserDefaultsManager.nickname)님의 다마고치", navBtnType: .right(.one))
        viewTransition(viewController: vc, transitionStyle: .resetRootVCwithNav)
    }
    
}

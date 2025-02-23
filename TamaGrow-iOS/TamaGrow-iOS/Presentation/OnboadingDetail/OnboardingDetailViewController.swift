//
//  OnboardingDetailViewController.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

final class OnboardingDetailViewController: BaseViewController {
    
    private let mainView: SelectedTamaPopupView
    
    init(mainView: SelectedTamaPopupView) {
        self.mainView = mainView
        
        super.init()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setLayout() {
//        mainView.snp.makeConstraints {
//            $0.center.equalTo(view.safeAreaLayoutGuide)
//        }
    }
    
}

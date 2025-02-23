//
//  MainViewController.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

import RxCocoa
import RxSwift

final class MainViewController: BaseViewController {
    
    private let viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    
    private let mainView = MainView()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        
        super.init(navTitle: StringLiterals.Main.navTitle, navBtnType: .right(.one))
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = StringLiterals.Main.navTitle
        mainView.configureUserDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func settingBtnTapped() {
        super.settingBtnTapped()
        
        let vc = SettingViewController(viewModel: SettingViewModel())
        viewTransition(viewController: vc, transitionStyle: .push)
    }
    
}

private extension MainViewController {
    
    func bind() {
        let input = MainViewModel.Input(
            riceTextField: mainView.riceTextField.textField.rx.text.orEmpty,
            waterTextField: mainView.waterTextField.textField.rx.text.orEmpty,
            riceTextFieldReturn: mainView.riceTextField.textField.rx.controlEvent(.editingDidEndOnExit),
            waterTextFieldReturn: mainView.waterTextField.textField.rx.controlEvent(.editingDidEndOnExit),
            riceEatBtnTapped: mainView.eatRiceBtn.eatBtn.rx.controlEvent(.touchUpInside), waterEatBtnTapped: mainView.eatWaterBtn.eatBtn.rx.controlEvent(.touchUpInside)
        )
        
        let output = viewModel.transform(input: input)
        
        output.riceTextFieldText
            .asDriver(onErrorJustReturn: "")
            .drive(with: self) { owner, text in
                switch text == "error" {
                case true:
                    let alert = UIAlertManager.showAlert(title: StringLiterals.Main.riceFailTitle, message: StringLiterals.Main.riceFailMessage)
                    owner.present(alert, animated: true)
                    owner.mainView.riceTextField.textField.text = ""
                case false:
                    owner.mainView.riceTextField.textField.text = text
                }
            }.disposed(by: disposeBag)
        
        output.waterTextFieldText
            .asDriver(onErrorJustReturn: "")
            .drive(with: self) { owner, text in
                switch text == "error" {
                case true:
                    let alert = UIAlertManager.showAlert(title: StringLiterals.Main.waterFailTitle, message: StringLiterals.Main.riceFailMessage)
                    owner.present(alert, animated: true)
                    owner.mainView.waterTextField.textField.text = ""
                case false:
                    owner.mainView.waterTextField.textField.text = text
                }
            }.disposed(by: disposeBag)
        
        output.reloadUserDefaults
            .asDriver()
            .drive(with: self) { owner, _ in
                owner.mainView.configureUserDefaults()
            }.disposed(by: disposeBag)
        
    }
    
}


//extension MainViewController: UITextFieldDelegate {

//텍스트필드가 활성화되면 키보드레이아웃의 상단을 각 텍스트필드 바텀으로 잡아주려하였으나, 적용되지 않을 뿐더러, return 시 망가진 레이아웃을 그대로 반환
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        print(#function)
//
//        // 기존의 제약조건을 모두 비활성화
//        mainView.keyboardLayoutGuide.topAnchor.constraint(equalTo: mainView.riceTextField.bottomAnchor).isActive = false
//        mainView.keyboardLayoutGuide.topAnchor.constraint(equalTo: mainView.waterTextField.bottomAnchor).isActive = false
//
//        // 현재 활성화된 UITextField 기준으로 키보드 위치 조정
//        mainView.keyboardLayoutGuide.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
//
//        return true
//    }

//}

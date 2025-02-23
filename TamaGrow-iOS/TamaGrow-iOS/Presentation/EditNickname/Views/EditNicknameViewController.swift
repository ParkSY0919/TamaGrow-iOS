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
    private let disposeBag = DisposeBag()
    
    private let mainView = EditNicknameView()
    
    init(viewModel: EditNicknameViewModel) {
        self.viewModel = viewModel
        
        super.init(navTitle: StringLiterals.EditNickname.navTitle, navBtnType: .right(.save))
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }

    private func bind() {
        let input = EditNicknameViewModel.Input(
            textFieldText: mainView.textField.rx.text.orEmpty,
            navRightBtnTap: self.navigationItem.rightBarButtonItem?.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.navRightBtnTap
            .drive(with: self, onNext: { owner, nickname in
                print("#nickname: \(nickname)")
                switch nickname == "error" {
                case true:
                    let alert = UIAlertManager.showAlert(title: "닉네임 변경 실패", message: "2글자 이상 6글자 이하로 작성해주세요")
                    owner.present(alert, animated: true)
                case false:
                    UserDefaultsManager.nickname = nickname
                    owner.navigationController?.popViewController(animated: true)
                }
            }).disposed(by: disposeBag)
    }
    
}

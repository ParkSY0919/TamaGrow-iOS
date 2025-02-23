//
//  EditNicknameViewModel.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/24/25.
//

import UIKit

import RxCocoa
import RxSwift

final class EditNicknameViewModel: ViewModelProtocol {
    
    private var currentNickname: String = UserDefaultsManager.nickname
    private let disposeBag = DisposeBag()
    
    struct Input {
        let textFieldText: ControlProperty<String>
        let navRightBtnTap: ControlEvent<()>?
    }
    
    struct Output {
        let navRightBtnTap: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let currentNickname = PublishRelay<String>()
        
        input.textFieldText
            .bind(with: self) { owner, nickname in
                owner.currentNickname = (2...6).contains(nickname.count)
                    ? nickname : "error"
            }
            .disposed(by: disposeBag)
        
        input.navRightBtnTap?.asDriver()
            .drive(with: self, onNext: { owner, _ in
                currentNickname.accept(owner.currentNickname)
            }).disposed(by: disposeBag)
        
        return Output(
            navRightBtnTap: currentNickname.asDriver(
                onErrorJustReturn: "error"
            )
        )
    }
    
}



//
//  OnboardingDetailViewModel.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

import RxCocoa
import RxSwift

final class OnboardingDetailViewModel: ViewModelProtocol {
    
    let leftBtnTitle: String
    let rightBtnTitle: String
    let tamaImage: UIImage
    let tamaName: String
    private let disposeBag = DisposeBag()
    
    init(leftBtnTitle: String, rightBtnTitle: String, tamaImage: UIImage, tamaName: String) {
        self.leftBtnTitle = leftBtnTitle
        self.rightBtnTitle = rightBtnTitle
        self.tamaImage = tamaImage
        self.tamaName = tamaName
    }
    
    struct Input {
        let navLeftBtnTapped: ControlEvent<Void>
        let navRightBtnTapped: ControlEvent<Void>
    }
    struct Output {
        let navLeftBtnTapped: Driver<Void>
        let navRightBtnTapped: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let leftBtnTapped = PublishRelay<Void>()
        let rightBtnTapped = PublishRelay<Void>()
        
        input.navLeftBtnTapped
            .bind(with: self) { owner, _ in
                leftBtnTapped.accept(())
            }.disposed(by: disposeBag)
        
        input.navRightBtnTapped
            .bind(with: self, onNext: { owner, _ in
                UserDefaultsManager.isOnboarding = false
                for i in TamaType.allCases {
                    if i.rawValue == owner.tamaName {
                        UserDefaultsManager.tamaType = i.rawValue
                    }
                }
                rightBtnTapped.accept(())
            })
            .disposed(by: disposeBag)
        
        return Output(
            navLeftBtnTapped: leftBtnTapped.asDriver(onErrorJustReturn: ()),
            navRightBtnTapped: rightBtnTapped.asDriver(onErrorJustReturn: ())
        )
    }
    
}

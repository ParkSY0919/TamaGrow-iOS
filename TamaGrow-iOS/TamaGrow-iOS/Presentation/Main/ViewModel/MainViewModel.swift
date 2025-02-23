//
//  MainViewModel.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import Foundation

import RxCocoa
import RxSwift

final class MainViewModel: ViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    private let currentRiceText = BehaviorRelay<String>(value: "")
    private let currentWaterText = BehaviorRelay<String>(value: "")
    
    struct Input {
        let riceTextField: ControlProperty<String>
        let waterTextField: ControlProperty<String>
        let riceTextFieldReturn: ControlEvent<()>
        let waterTextFieldReturn: ControlEvent<()>
        let riceEatBtnTapped: ControlEvent<()>
        let waterEatBtnTapped: ControlEvent<()>
    }
    
    struct Output {
        let riceTextFieldText: PublishRelay<String>
        let waterTextFieldText: PublishRelay<String>
        let reloadUserDefaults: BehaviorRelay<Void>
    }
    
    func transform(input: Input) -> Output {
        let riceTextFieldText = PublishRelay<String>()
        let waterTextFieldText = PublishRelay<String>()
        let reloadUserDefaults = BehaviorRelay(value: ())
        
        input.riceTextField
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .distinctUntilChanged()
            .map { text -> String in
                if text.isEmpty { return "" }
                guard
                    let number = Int(text), number < 100
                else { return "error" }
                return text
            }
            .subscribe(with: self, onNext: { owner, text in
                if text != "error" {
                    owner.currentRiceText.accept(text)
                }
                riceTextFieldText.accept(text)
            }).disposed(by: disposeBag)
        
        input.waterTextField
            .distinctUntilChanged()
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines)}
            .map { text -> String in
                if text.isEmpty { return "" }
                guard let number = Int(text), number < 50 else { return "error" }
                return text
            }
            .subscribe(with: self, onNext: { owner, text in
                if text != "error" {
                    owner.currentWaterText.accept(text)
                }
                waterTextFieldText.accept(text)
            }).disposed(by: disposeBag)
        
        input.riceEatBtnTapped
            .asDriver()
            .drive(with: self) { owner, _ in
                let riceText = owner.currentRiceText.value
                switch riceText == "" {
                case true:
                    let currentRice = UserDefaultsManager.rice
                    UserDefaultsManager.rice = currentRice + 1
                case false:
                    if let riceAmount = Int(riceText) {
                        let currentRice = UserDefaultsManager.rice
                        UserDefaultsManager.rice = currentRice + riceAmount
                    }
                }
                owner.currentRiceText.accept("")
                riceTextFieldText.accept("")
                reloadUserDefaults.accept(())
            }.disposed(by: disposeBag)
        
        input.waterEatBtnTapped
            .asDriver()
            .drive(with: self) { owner, _ in
                let waterText = owner.currentWaterText.value
                switch waterText == "" {
                case true:
                    let currentWater = UserDefaultsManager.water
                    UserDefaultsManager.water = currentWater + 1
                case false:
                    if let waterAmount = Int(waterText) {
                        let currentWater = UserDefaultsManager.water
                        UserDefaultsManager.water = currentWater + waterAmount
                    }
                }
                owner.currentWaterText.accept("")
                waterTextFieldText.accept("")
                reloadUserDefaults.accept(())
            }.disposed(by: disposeBag)
        
        return Output(
            riceTextFieldText: riceTextFieldText,
            waterTextFieldText: waterTextFieldText,
            reloadUserDefaults: reloadUserDefaults
        )
    }
    
}

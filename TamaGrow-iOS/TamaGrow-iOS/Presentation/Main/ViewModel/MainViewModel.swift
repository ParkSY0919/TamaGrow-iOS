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
    
    struct Input {
        let riceTextField: ControlProperty<String>
        let waterTextField: ControlProperty<String>
    }
    
    struct Output {
        let riceTextFieldText: PublishRelay<String>
        let waterTextFieldText: PublishRelay<String>
    }
    
    func transform(input: Input) -> Output {
        let riceTextFieldText = PublishRelay<String>()
        let waterTextFieldText = PublishRelay<String>()
        
        input.riceTextField
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .distinctUntilChanged()
            .map { text -> String in
                if text.isEmpty { return "" }
                guard let number = Int(text), number <= 99 else { return "error" }
                return text
            }
            .subscribe(with: self, onNext: { owner, text in
                waterTextFieldText.accept(text)
            })
            .disposed(by: disposeBag)
        
        input.waterTextField
            .distinctUntilChanged()
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines)}
            .map { text -> String in
                if text.isEmpty { return "" }
                guard let number = Int(text), number <= 49 else { return "error" }
                return text
            }
            .subscribe(with: self, onNext: { owner, text in
                waterTextFieldText.accept(text)
            })
            .disposed(by: disposeBag)
        
        return Output(
            riceTextFieldText: riceTextFieldText,
            waterTextFieldText: waterTextFieldText
        )
    }
    
}

private extension MainViewModel {
    
}

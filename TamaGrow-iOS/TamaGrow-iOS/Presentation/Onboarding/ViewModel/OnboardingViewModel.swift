//
//  OnboardingViewModel.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/24/25.
//

import UIKit

import RxCocoa
import RxSwift

final class OnboardingViewModel: ViewModelProtocol {
    
    struct Input {
        let selectedIndex: PublishSubject<Int>
    }
    
    struct Output {
        let items: Driver<[TamaModel]>
        let selectedTama: PublishRelay<TamaModel>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let items = Observable.just(TamaModel.dummy)
        
        let selectedTama = PublishRelay<TamaModel>()
        
        input.selectedIndex
            .withLatestFrom(items) { index, list in
                list.indices.contains(index) ? list[index]
                : TamaModel(image: UIImage(resource: .no), name: StringLiterals.SelectedTama.preparingTama)
            }
            .bind(to: selectedTama)
            .disposed(by: disposeBag)
        
        return Output(
            items: items.asDriver(onErrorJustReturn: []),
            selectedTama: selectedTama
        )
    }
    
}



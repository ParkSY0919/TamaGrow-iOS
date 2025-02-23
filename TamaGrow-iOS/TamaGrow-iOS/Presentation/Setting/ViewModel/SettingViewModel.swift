//
//  SettingViewModel.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/24/25.
//

import Foundation

import RxCocoa
import RxSwift

final class SettingViewModel: ViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    
    private let items = Observable.just([
        SettingCellModel(icon: StringLiterals.Setting.nameCellImage, title: StringLiterals.Setting.nameCellTitle, accessoryText: UserDefaultsManager.nickname),
        SettingCellModel(icon: StringLiterals.Setting.changeTamaCellImage, title: StringLiterals.Setting.changeTamaCellTitle, accessoryText: ""),
        SettingCellModel(icon: StringLiterals.Setting.resetTamaCellImage, title: StringLiterals.Setting.resetCellTitle, accessoryText: "")
    ])
    
    struct Input {
        let tableViewSelected: ControlEvent<IndexPath>
    }
    
    struct Output {
        let settingCellItems: Observable<[SettingCellModel]>
        let tableViewSelectedRow: PublishRelay<Int>
    }
    
    func transform(input: Input) -> Output {
        let tableViewSelectedRow = PublishRelay<Int>()
        
        input.tableViewSelected
            .asDriver()
            .drive(with: self) { owner, indexPath in
                tableViewSelectedRow.accept(indexPath.row)
            }.disposed(by: disposeBag)
        
        return Output(
            settingCellItems: items,
            tableViewSelectedRow: tableViewSelectedRow
        )
    }
    
}

//
//  SettingViewModel.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/24/25.
//

import RxCocoa
import RxSwift

final class SettingViewModel: ViewModelProtocol {
    
    private let items = Observable.just([
        SettingCellModel(icon: StringLiterals.Setting.nameCellImage, title: StringLiterals.Setting.nameCellTitle, accessoryText: UserDefaultsManager.nickname),
        SettingCellModel(icon: StringLiterals.Setting.changeTamaCellImage, title: StringLiterals.Setting.changeTamaCellTitle, accessoryText: ""),
        SettingCellModel(icon: StringLiterals.Setting.resetTamaCellImage, title: StringLiterals.Setting.resetCellTitle, accessoryText: "")
    ])
    
    struct Input {}
    
    struct Output {
        let settingCellItems: Observable<[SettingCellModel]>
    }
    
    func transform(input: Input) -> Output {
        
        return Output(settingCellItems: items)
    }
    
}

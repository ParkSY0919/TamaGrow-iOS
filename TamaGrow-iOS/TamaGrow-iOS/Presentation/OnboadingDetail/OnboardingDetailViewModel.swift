//
//  OnboardingDetailViewModel.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

final class OnboardingDetailViewModel {
    
    let leftBtnTitle: String
    let rightBtnTitle: String
    let tamaImage: UIImage
    let tamaName: String
    
    init(leftBtnTitle: String, rightBtnTitle: String, tamaImage: UIImage, tamaName: String) {
        self.leftBtnTitle = leftBtnTitle
        self.rightBtnTitle = rightBtnTitle
        self.tamaImage = tamaImage
        self.tamaName = tamaName
    }
    
}

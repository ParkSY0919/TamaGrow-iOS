//
//  TamaEatButtonView.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

import SnapKit
import Then

final class TamaEatButtonView: BaseView {
    
    private let btnTitle: String
    private let btnImage: UIImage
    let eatBtn = UIButton()
    
    init(btnTitle: String, btnImage: UIImage?) {
        self.btnTitle = btnTitle
        self.btnImage = btnImage ?? UIImage()
        
        super.init(frame: .zero)
    }
    
    override func setHierarchy() {
        self.addSubview(eatBtn)
    }
    
    override func setLayout() {
        eatBtn.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func setStyle() {
        eatBtn.do {
            var config = UIButton.Configuration.plain()
            config.image = btnImage
            config.title = btnTitle
            config.baseForegroundColor = UIColor.fontLayer
            $0.configuration = config
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.fontLayer.cgColor
        }
    }
    
}

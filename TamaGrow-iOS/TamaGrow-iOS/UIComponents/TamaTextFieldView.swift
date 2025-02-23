//
//  TamaTextFieldView.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

import SnapKit
import Then

final class TamaTextFieldView: BaseView {
    
    private let underLineView = UIView()
    let textField = UITextField()
    
    init(placeholder: String) {
        textField.placeholder = placeholder
        
        super.init(frame: .zero)
    }
    
    override func setHierarchy() {
        self.addSubviews(underLineView, textField)
    }
    
    override func setLayout() {
        underLineView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }
        
        textField.snp.makeConstraints {
            $0.bottom.equalTo(underLineView.snp.top).offset(-10)
            $0.centerX.equalTo(underLineView)
        }
    }
    
    override func setStyle() {
        underLineView.backgroundColor = UIColor.fontLayer
        
        textField.do {
            $0.borderStyle = .none
            $0.font = .systemFont(ofSize: 15, weight: .black)
            $0.textColor = UIColor.fontLayer
            $0.textAlignment = .center
        }
    }
    
}

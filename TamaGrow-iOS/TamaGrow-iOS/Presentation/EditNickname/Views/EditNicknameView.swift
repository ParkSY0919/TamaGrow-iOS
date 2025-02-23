//
//  EditNicknameView.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/24/25.
//

import UIKit

import SnapKit
import Then

final class EditNicknameView: BaseView {
    
    private let underLine = UIView()
    let textField = UITextField()
    
    override func setHierarchy() {
        self.addSubviews(underLine, textField)
    }
    
    override func setLayout() {
        underLine.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(60)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(1)
        }
        
        textField.snp.makeConstraints {
            $0.bottom.equalTo(underLine.snp.top).offset(-10)
            $0.horizontalEdges.equalTo(underLine)
        }
    }
    
    override func setStyle() {
        underLine.backgroundColor = UIColor.fontLayer
        
        textField.do {
            $0.placeholder = StringLiterals.EditNickname.editNicknamePlaceholder
            $0.text = UserDefaultsManager.nickname
            $0.font = .systemFont(ofSize: 15, weight: .regular)
            $0.textColor = UIColor.fontLayer
            $0.textAlignment = .left
        }
    }
    
}

//
//  MainView.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

import SnapKit
import Then

final class MainView: BaseView {
    
    private let navSeparatorLine = UIView()
    private let bubbleView = UIImageView()
    private let messageLabel = UILabel()
    private let tamaView = TamaView()
    private let tamaInfoLabel = UILabel()
    let riceTextField = TamaTextFieldView(placeholder: StringLiterals.Main.riceTextFieldPlaceholder)
    let eatRiceBtn = TamaEatButtonView(btnTitle: " 밥먹기", btnImage: UIImage(systemName: "leaf.circle"))
    let waterTextField = TamaTextFieldView(placeholder: StringLiterals.Main.waterTextFieldPlaceholder)
    let eatWaterBtn = TamaEatButtonView(btnTitle: " 물먹기", btnImage: UIImage(systemName: "drop.circle"))
    
    init() {
        super.init(frame: .zero)
        
        configureUserDefaults()
    }
    
    override func setHierarchy() {
        self.addSubviews(navSeparatorLine, bubbleView, tamaView, tamaInfoLabel, riceTextField, eatRiceBtn, waterTextField, eatWaterBtn)
        bubbleView.addSubview(messageLabel)
    }
    
    override func setLayout() {
        navSeparatorLine.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(0.5)
        }
        
        bubbleView.snp.makeConstraints {
            $0.top.equalTo(navSeparatorLine.snp.bottom).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(60)
            $0.height.equalTo(140)
        }
        
        messageLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        tamaView.snp.makeConstraints {
            $0.top.equalTo(bubbleView.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(70)
            $0.height.equalTo(tamaView.snp.width)
        }
        
        tamaInfoLabel.snp.makeConstraints {
            $0.top.equalTo(tamaView.snp.bottom).offset(8)
            $0.centerX.horizontalEdges.equalToSuperview()
        }
        
        riceTextField.snp.makeConstraints {
            $0.top.equalTo(tamaInfoLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalTo(eatRiceBtn.snp.leading).offset(-15)
            $0.height.equalTo(40)
        }
        
        eatRiceBtn.snp.makeConstraints {
            $0.top.equalTo(riceTextField)
            $0.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(40)
        }
        
        waterTextField.snp.makeConstraints {
            $0.top.equalTo(riceTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalTo(riceTextField)
            $0.height.equalTo(40)
        }
        
        eatWaterBtn.snp.makeConstraints {
            $0.top.equalTo(waterTextField)
            $0.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(40)
        }
    }
    
    override func setStyle() {
        navSeparatorLine.do {
            $0.backgroundColor = UIColor.fontLayer.withAlphaComponent(0.4)
        }
        
        bubbleView.do {
            $0.image = UIImage(resource: .bubble)
        }
        
        messageLabel.setLabelUI(
            "text",
            font: .systemFont(ofSize: 14, weight: .semibold),
            textColor: UIColor.fontLayer,
            alignment: .center,
            numberOfLines: 0
        )
        
        tamaInfoLabel.setLabelUI(
            "LV0 • 밥알 0개 • 물방울 0개",
            font: .systemFont(ofSize: 14, weight: .regular),
            textColor: UIColor.fontLayer,
            alignment: .center
        )
        
        riceTextField.backgroundColor = UIColor.bg
    }
    
    func configureUserDefaults() {
        let tamaType = UserDefaultsManager.tamaType
        for i in TamaType.allCases {
            if i.rawValue == tamaType {
                tamaView.iconImageView.image = i.tamaImage
            }
        }
        
        messageLabel.text = StringLiterals.Main.messages.randomElement()
        
        tamaView.nameLabel.setLabelUI(tamaType, font: .systemFont(ofSize: 16, weight: .bold), textColor: UIColor.fontLayer)
        
        tamaInfoLabel.text = StringLiterals.Main.tamaDetail
    }
    
    func setKeyboard() {
        self.keyboardLayoutGuide.topAnchor.constraint(equalTo: riceTextField.bottomAnchor).isActive = true
    }
    
}


/*
 1. keyboardLayoutGuide을 사용하여 각 rice, water TexrField가 활성화 됐을 때 해당 텍스트필드의 bottom을 기준으로 잡아주고 싶다.

 */

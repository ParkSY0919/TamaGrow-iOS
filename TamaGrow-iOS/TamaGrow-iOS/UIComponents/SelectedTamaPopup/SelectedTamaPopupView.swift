//
//  SelectedTamaPopupView.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

import SnapKit
import Then

final class SelectedTamaPopupView: BaseView {
    
    //MARK: - UI Properties
    private let popupContainerView = UIView()
    private let tamaView = TamaView()
    private let separatorLine = UIView()
    private let tamaInfoLabel = UILabel()
    private let btnSeparatorLine1 = UIView()
    private let btnSeparatorLine2 = UIView()
    let leftBtn = UIButton()
    let rightBtn = UIButton()
    
    
    //MARK: - Init
    init(leftBtnTitle: String, rightBtnTitle: String, tamaImage: UIImage, tamaName: String) {
        self.leftBtn.setTitle(leftBtnTitle, for: .normal)
        self.rightBtn.setTitle(rightBtnTitle, for: .normal)
        self.tamaView.iconImageView.image = tamaImage
        self.tamaView.nameLabel.text = tamaName
        StringLiterals.SelectedTama.tamaInfo = tamaName
        
        super.init(frame: .zero)
    }

    override func setHierarchy() {
        self.addSubview(popupContainerView)
        popupContainerView.addSubviews(tamaView, separatorLine, tamaInfoLabel, btnSeparatorLine1, btnSeparatorLine2, leftBtn, rightBtn)
    }
    
    override func setLayout() {
        popupContainerView.snp.makeConstraints {
            $0.verticalEdges.equalTo(self.safeAreaLayoutGuide).inset(170)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(40)
        }
        
        tamaView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.horizontalEdges.equalToSuperview().inset(70)
            $0.height.equalTo(tamaView.snp.width)
        }
        
        separatorLine.snp.makeConstraints {
            $0.top.equalTo(tamaView.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.height.equalTo(1)
        }
        
        //현재 왜 height ambiguous 발생?
        tamaInfoLabel.snp.makeConstraints {
            $0.top.equalTo(separatorLine.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(separatorLine).inset(-10)
        }
        
        btnSeparatorLine1.snp.makeConstraints {
            $0.top.equalTo(tamaInfoLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        btnSeparatorLine2.snp.makeConstraints {
            $0.top.equalTo(btnSeparatorLine1.snp.bottom)
            $0.centerX.equalTo(btnSeparatorLine1)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(0.5)
        }
        
        leftBtn.snp.makeConstraints {
            $0.top.equalTo(btnSeparatorLine1.snp.bottom)
            $0.leading.bottom.equalToSuperview()
            $0.trailing.equalTo(btnSeparatorLine2.snp.leading)
        }
        
        rightBtn.snp.makeConstraints {
            $0.top.equalTo(btnSeparatorLine1.snp.bottom)
            $0.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(btnSeparatorLine2.snp.trailing)
        }
        
    }
    
    override func setStyle() {
        popupContainerView.do {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.bg
        }
        
        tamaView.do {
            $0.nameLabel.font = .systemFont(ofSize: 13, weight: .bold)
        }
        
        separatorLine.do {
            $0.backgroundColor = UIColor.fontLayer
        }
        
        tamaInfoLabel.setLabelUI(StringLiterals.SelectedTama.tamaInfo, font: .systemFont(ofSize: 13, weight: .medium), textColor: UIColor.fontLayer, alignment: .center, numberOfLines: 0)
        
        [btnSeparatorLine1, btnSeparatorLine2].forEach { i in
            i.do {
                $0.backgroundColor = UIColor.fontLayer.withAlphaComponent(0.2)
            }
        }
        
        [leftBtn, rightBtn].forEach({ i in
            i.do {
                if i == leftBtn {
                    $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
                }
                $0.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
                $0.setTitleColor(UIColor.fontLayer, for: .normal)
            }
        })
    }
    
}

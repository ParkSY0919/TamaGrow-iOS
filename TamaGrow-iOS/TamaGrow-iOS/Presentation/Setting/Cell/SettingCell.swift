//
//  SettingCell.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/24/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class SettingCell: BaseTableViewCell {
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let accessoryLabel = UILabel()
    private let accessoryArrow = UIImageView()
    
    override func setHierarchy() {
        contentView.addSubviews(
            iconImageView,
            titleLabel,
            accessoryArrow,
            accessoryLabel
        )
    }
    
    override func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(iconImageView.snp.right).offset(12)
        }
        
        accessoryArrow.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(16)
            $0.size.equalTo(16)
        }
        
        accessoryLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(accessoryArrow.snp.left).offset(-6)
        }
    }
    
    override func setStyle() {
        contentView.backgroundColor = UIColor.bg
        
        iconImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.tintColor = UIColor.fontLayer
        }
        
        titleLabel.setLabelUI("", font: .systemFont(ofSize: 15, weight: .semibold), textColor: UIColor.black)
        
        accessoryLabel.setLabelUI("", font: .systemFont(ofSize: 14, weight: .medium), textColor: UIColor.fontLayer.withAlphaComponent(0.4))
        
        accessoryArrow.do {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(systemName: "chevron.right")
            $0.tintColor = UIColor.fontLayer.withAlphaComponent(0.4)
        }
    }

    func configureSettingCell(model: SettingCellModel, isChangeNickname: Bool = false) {
        iconImageView.image = UIImage(systemName: model.icon)
        titleLabel.text = model.title
        accessoryLabel.text = isChangeNickname ?
            UserDefaultsManager.nickname : model.accessoryText
        accessoryLabel.isHidden = model.accessoryText.isEmpty
        
    }
    
}

//
//  TamaView.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

import SnapKit
import Then

final class TamaView: BaseView {
    
    let iconImageView = UIImageView()
    private let nameContainerView = UIView()
    let nameLabel = UILabel()
    
    override func setHierarchy() {
        self.addSubviews(iconImageView, nameContainerView)
        nameContainerView.addSubview(nameLabel)
    }
    
    override func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.height.equalTo(iconImageView.snp.width)
        }
        
        nameContainerView.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(nameLabel.snp.width).inset(-10)
            $0.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setStyle() {
        self.backgroundColor = UIColor.bg
        
        iconImageView.do {
            $0.setImageView(image: UIImage(resource: .no), cornerRadius: 10)
        }
        
        nameContainerView.do {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.fontLayer.cgColor
            $0.layer.cornerRadius = 4
        }
        
        nameLabel.setLabelUI(
            "준비중이에요",
            font: .systemFont(ofSize: 13, weight: .semibold),
            textColor: UIColor.fontLayer,
            alignment: .center
        )
    }
    
}

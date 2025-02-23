//
//  SelectedTamaCell.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

import SnapKit
import Then

final class SelectedTamaCell: BaseCollectionViewCell {
    
    private let tamaView = TamaView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        tamaView.iconImageView.image = nil
        tamaView.nameLabel.text = nil
    }
    
    override func setHierarchy() {
        contentView.addSubview(tamaView)
    }
    
    override func setLayout() {
        tamaView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureTamaView(image: UIImage, name: String) {
        tamaView.iconImageView.image = image
        tamaView.nameLabel.text = name
    }
    
}

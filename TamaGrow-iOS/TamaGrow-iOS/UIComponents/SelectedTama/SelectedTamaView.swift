//
//  SelectedTamaView.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

import SnapKit
import Then

final class SelectedTamaView: BaseView {
    
    private var collectionViewLayout: UICollectionViewFlowLayout!
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
    
    override func setHierarchy() {
        self.addSubview(collectionView)
    }
    
    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func setStyle() {
        collectionView.do {
            $0.backgroundColor = UIColor.bg
            $0.register(SelectedTamaCell.self, forCellWithReuseIdentifier: SelectedTamaCell.cellIdentifier)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let ableScreenWidth = (self.bounds.width - 40 - 50) / 3
        collectionViewLayout.itemSize = CGSize(width: ableScreenWidth, height: ableScreenWidth)
    }
    
}

private extension SelectedTamaView {
    
    func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.do {
            $0.minimumInteritemSpacing = 25
            $0.minimumLineSpacing = 20
            $0.scrollDirection = .vertical
            $0.sectionInset = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        }
        self.collectionViewLayout = layout
        
        return self.collectionViewLayout
    }
    
}

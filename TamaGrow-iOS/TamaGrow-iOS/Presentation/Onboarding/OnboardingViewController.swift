//
//  OnboardingViewController.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    
    private let mainView = SelectedTamaView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        setDelegate()
    }
    
}

private extension OnboardingViewController {
    
    func setDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leftTitle = StringLiterals.System.cancel
        let rightTitle = StringLiterals.System.start
        var tamaImge = UIImage(resource: .no)
        var tamaName = ""
        switch indexPath.item {
        case 0:
            tamaImge = UIImage(resource: ._1_6)
            tamaName = StringLiterals.SelectedTama.smilingTama
        case 1:
            tamaImge = UIImage(resource: ._2_6)
            tamaName = StringLiterals.SelectedTama.smilingTama
        case 2:
            tamaImge = UIImage(resource: ._3_6)
            tamaName = StringLiterals.SelectedTama.sparklingTama
        default:
            print("didSelectItemAt error")
        }
        let nextViewModel = OnboardingDetailViewModel(
            leftBtnTitle: leftTitle,
            rightBtnTitle: rightTitle,
            tamaImage: tamaImge,
            tamaName: tamaName
        )
        let vc = OnboardingDetailViewController(viewModel: nextViewModel)
        viewTransition(viewController: vc, transitionStyle: .overCurrentContext)
    }
    
}

extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedTamaCell.cellIdentifier, for: indexPath) as! SelectedTamaCell
        
        switch indexPath.item {
        case 0:
            cell.configureTamaView(image: UIImage(resource: ._1_6), name: StringLiterals.SelectedTama.tinglingTama)
        case 1:
            cell.configureTamaView(image: UIImage(resource: ._2_6), name: StringLiterals.SelectedTama.smilingTama)
        case 2:
            cell.configureTamaView(image: UIImage(resource: ._3_6), name: StringLiterals.SelectedTama.sparklingTama)
        default:
            cell.configureTamaView(image: UIImage(resource: .no), name: StringLiterals.SelectedTama.preparingTama)
        }
        return cell
    }
    
}

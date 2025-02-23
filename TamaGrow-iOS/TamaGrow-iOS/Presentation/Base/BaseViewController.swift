//
//  BaseViewController.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/22/25.
//

import UIKit

import SnapKit
import Then

class BaseViewController: UIViewController {
    
    var navTitle: String?
    var navBtnType: NavigationBtnType
    
    init(navTitle: String? = nil , navBtnType: NavigationBtnType = .none) {
        self.navTitle = navTitle
        self.navBtnType = navBtnType
        print("BaseViewController init 실행")
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseVCNavSetting()
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    private func baseVCNavSetting() {
        navigationController?.navigationBar.backgroundColor = UIColor.bg
        
        switch navTitle==nil {
        case true:
            print("navTitle is nil")
        case false:
            print("navTitle is not nil")
            navigationItem.title = navTitle
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
        
        switch navBtnType {
        case .none:
            print("navBtnType none")
        case .left(let left):
            switch left {
            case .none:
                print("navBtnType left none")
            case .pop:
                let navLeftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(popBtnTapped))
                navigationItem.leftBarButtonItem = navLeftItem
            }
        case .right(let right):
            switch right {
            case .none:
                print("navBtnType right none")
            case .double:
                let firstItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refreshBtnTapped))
                let secondItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchBtnTapped))
                navigationItem.setRightBarButtonItems([firstItem, secondItem], animated: true)
            }
        case .both(let left, let right):
            print("아직 이런 경우 없음")
        }
    }
    
    func setHierarchy() {}
    
    func setLayout() {}
    
    func setStyle() {
        view.backgroundColor = UIColor.bg
    }
    
    func viewTransition<T: UIViewController>(viewController: T, transitionStyle: ViewTransitionType) {
        switch transitionStyle {
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .resetRootVCwithNav:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            
            let newRootVC = UINavigationController(rootViewController: viewController)
            
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { window.rootViewController = newRootVC },
                              completion: nil)
            window.makeKeyAndVisible()
        case .resetRootVCwithoutNav:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            
            let newRootVC = viewController
            
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { window.rootViewController = newRootVC },
                              completion: nil)
            window.makeKeyAndVisible()
        case .present:
            return self.present(viewController, animated: true)
        case .presentWithNav:
            let nav = UINavigationController(rootViewController: viewController)
            nav.sheetPresentationController?.prefersGrabberVisible = true
            return self.present(nav, animated: true)
        case .presentFullScreenWithNav:
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            return self.present(nav, animated: true)
        case .overCurrentContext:
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            return self.present(viewController, animated: true)
        }
    }
    
    @objc
    func popBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func refreshBtnTapped() {
        print(#function)
    }
    
    @objc
    func searchBtnTapped() {
        print(#function)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

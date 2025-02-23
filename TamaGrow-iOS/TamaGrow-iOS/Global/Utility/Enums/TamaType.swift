//
//  TamaType.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/23/25.
//

import UIKit

enum TamaType: String, CaseIterable {
    case tinglingTama = "따끔따끔 다마고치"
    case smilingTama = "방실방실 다마고치"
    case sparklingTama = "반짝반짝 다마고치"
    case none = "준비중이에요"
    
    var tamaImage: UIImage {
        var imageBase = ""
        switch self {
        case .tinglingTama:
            imageBase = "1-"
        case .smilingTama:
            imageBase = "2-"
        case .sparklingTama:
            imageBase = "3-"
        case .none:
            imageBase = "no"
        }
        print("@@@ \(imageBase)")
        switch UserDefaultsManager.level {
        case 0..<20:
            return UIImage(named: imageBase+"1") ?? UIImage()
        case 20..<30:
            return UIImage(named: imageBase+"2") ?? UIImage()
        case 30..<40:
            return UIImage(named: imageBase+"3") ?? UIImage()
        case 40..<50:
            return UIImage(named: imageBase+"4") ?? UIImage()
        case 50..<60:
            return UIImage(named: imageBase+"5") ?? UIImage()
        case 60..<70:
            return UIImage(named: imageBase+"6") ?? UIImage()
        case 70..<80:
            return UIImage(named: imageBase+"7") ?? UIImage()
        case 80..<90:
            return UIImage(named: imageBase+"8") ?? UIImage()
        case 90..<100:
            return UIImage(named: imageBase+"9") ?? UIImage()
        case 100...:
            return UIImage(named: imageBase+"10") ?? UIImage()
        default:
            return UIImage(resource: .no)
        }
    }
}

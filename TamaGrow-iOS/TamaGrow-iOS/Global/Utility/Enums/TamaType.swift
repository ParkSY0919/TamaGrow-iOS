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
        switch UserDefaultsManager.level {
        case 1:
            return UIImage(named: imageBase+"1") ?? UIImage()
        case 2:
            return UIImage(named: imageBase+"2") ?? UIImage()
        case 3:
            return UIImage(named: imageBase+"3") ?? UIImage()
        case 4:
            return UIImage(named: imageBase+"4") ?? UIImage()
        case 5:
            return UIImage(named: imageBase+"5") ?? UIImage()
        case 6:
            return UIImage(named: imageBase+"6") ?? UIImage()
        case 7:
            return UIImage(named: imageBase+"7") ?? UIImage()
        case 8:
            return UIImage(named: imageBase+"8") ?? UIImage()
        case 9, 10:
            return UIImage(named: imageBase+"9") ?? UIImage()
        default:
            return UIImage(resource: .no)
        }
    }
}

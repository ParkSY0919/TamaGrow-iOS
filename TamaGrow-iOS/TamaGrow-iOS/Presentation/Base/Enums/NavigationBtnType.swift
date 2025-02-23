//
//  NavigationBtnType.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/22/25.
//

import Foundation

enum NavigationBtnType {
    case none
    case left(Left)
    case right(Right)
    case both(Left, Right)
    
    enum Left {
        case none
        case pop
    }
    
    enum Right {
        case none
        case one
        case save
        case double
    }
}

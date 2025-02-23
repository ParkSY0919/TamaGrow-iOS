//
//  StringLiterals.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/22/25.
//

import Foundation

enum StringLiterals {}

extension StringLiterals {
    
    enum System {
        static var cancel = "취소"
        static var start = "시작하기"
    }
    
    enum SelectedTama {
        private static var tamaName: String = ""
        
        static var tinglingTama = "따끔따끔 다마고치"
        static var smilingTama = "방실방실 다마고치"
        static var sparklingTama = "반짝반짝 다마고치"
        static var preparingTama = "준비중이에요"
        static var tamaInfo: String {
            get {
                let shortName = tamaName.split(separator: " ").first ?? "tamaInfo error"
                return "저는 \(tamaName)입니당 키는 100km\n몸무게는 150톤이에용\n성격은 화끈하고 날라다닙니당~!\n열심히 잘 먹고 잘 클 자신은\n있답니당 \(shortName)!"
            }
            set {
                tamaName = newValue
            }
        }
    }
    
}

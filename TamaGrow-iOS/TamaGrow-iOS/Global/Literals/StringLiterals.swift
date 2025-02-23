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
    
    enum Main {
        static var navTitle: String {
            return "\(UserDefaultsManager.nickname)님의 다마고치"
        }
        static var tamaDetail: String {
            return "LV\(UserDefaultsManager.level) • 밥알 \(UserDefaultsManager.rice)개 • 물방울 \(UserDefaultsManager.water)개"
        }
        static var messages: [String] = [
            "\(UserDefaultsManager.nickname)님, 밥 주세요! 🍚",
            "목이 말라요! 물 한 모금만요! 💧",
            "좋은 하루예요, \(UserDefaultsManager.nickname)님! 😊",
            "밥을 먹었더니 힘이 솟아요! 💪",
            "물 덕분에 상쾌해졌어요! 고마워요, \(UserDefaultsManager.nickname)님! 🙌",
            "\(UserDefaultsManager.nickname)님 덕분에 성장하고 있어요! 🚀",
            "배불러서 기분이 좋아요! 😋",
            "다음 레벨까지 조금만 더 먹으면 돼요! 🎯",
            "\(UserDefaultsManager.nickname)님, 저랑 더 오래 함께해 주세요! ❤️",
            "밥과 물을 잘 먹었더니 레벨업 했어요! 🎉"
        ]
        static var riceTextFieldPlaceholder = "밥주세용"
        static var waterTextFieldPlaceholder = "물주세용"
        static var riceFailTitle = "밥 먹기 실패"
        static var riceFailMessage = "99 이하의 숫자를 입력해주세요."
        static var waterFailTitle = "밥 먹기 실패"
        static var waterFailMessage = "99 이하의 숫자를 입력해주세요."
    }
    
    enum Setting {
        static var nameCellImage = "pencil"
        static var nameCellTitle = "내 이름 설정하기"
        static var changeTamaCellImage = "moon.fill"
        static var changeTamaCellTitle = "다마고치 변경하기"
        static var resetTamaCellImage = "arrow.clockwise"
        static var resetCellTitle = "데이터 초기화"
    }
    
}

//
//  UserDefaultsManager.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/22/25.
//

import Foundation

enum UserDefaultsManager {
    
    enum Key: String, CaseIterable {
        case isOnboarding
        case tamaType
        case nickname
        case level
        case rice
        case water
    }
    
    static func removeObject<T>(key: Key, type: T.Type) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    @TamaGrowUserDefaults(key: Key.isOnboarding.rawValue, defaultValue: true)
    static var isOnboarding
    
    @TamaGrowUserDefaults(key: Key.tamaType.rawValue, defaultValue: TamaType.none.rawValue)
    static var tamaType

    @TamaGrowUserDefaults(key: Key.nickname.rawValue, defaultValue: "대장")
    static var nickname
    
    @TamaGrowUserDefaults(key: Key.level.rawValue, defaultValue: 1)
    static var level
    
    @TamaGrowUserDefaults(key: Key.rice.rawValue, defaultValue: 0)
    static var rice
    
    @TamaGrowUserDefaults(key: Key.water.rawValue, defaultValue: 0)
    static var water
    
}

@propertyWrapper
struct TamaGrowUserDefaults<T: Hashable> {
    
    let key: String
    let defaultValue: T
    private let userDefaults = UserDefaults.standard
    
    var wrappedValue: T {
        get { userDefaults.object(forKey: key) as? T ?? defaultValue }
        set { userDefaults.set(newValue, forKey: key) }
    }
    
}

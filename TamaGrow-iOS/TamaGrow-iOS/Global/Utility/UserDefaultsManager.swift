//
//  UserDefaultsManager.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/22/25.
//

import Foundation

enum UserDefaultsManager {
    
    enum Key: String {
        case currentCity
    }
    
    static func removeObject<T: Hashable>(key: Key, type: T.Type) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }

    @TamaGrowUserDefaults(key: Key.currentCity.rawValue, defaultValue: false)
    static var currentCity
    
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

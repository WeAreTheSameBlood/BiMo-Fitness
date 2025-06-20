//
//  UserDefaults+didSeedData.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation

extension UserDefaults {
    private enum Keys { static let didSeedData = "didSeedData" }
    
    var didSeedData: Bool {
        get { bool(forKey: Keys.didSeedData) }
        set { set(newValue, forKey: Keys.didSeedData) }
    }
}

//
//  Item.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

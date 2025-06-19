//
//  LogType.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation

enum LogType {
    case message
    case error
}

// MARK: - Properties
extension LogType {
    var title: String? {
        switch self {
        case .message: "DEBUG"
            
        case .error: "ERROR"
        }
    }
}

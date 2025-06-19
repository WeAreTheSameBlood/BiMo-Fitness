//
//  LogModel.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation

struct LogModel {
    // MARK: - Properties
    let date = Date()
    let type: LogType
    let message: String
}

// MARK: - Log Message
extension LogModel {
    var logMessage: String {
        var result: String = "\(date): "
        if let type = type.title {
            result.append("[\(type)]")
            result.append(" ")
        }
        result.append(message)
        return result
    }
}


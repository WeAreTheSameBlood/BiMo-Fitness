//
//  LogService.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation
import Combine

public let log: LogService = LogServiceImpl()

public protocol LogService {
    func debug(message: String)
    func error(message: String)
    func error(error: Error)
}

public class LogServiceImpl: LogService {
    public func debug(message: String) {
        let model = LogModel(type: .message, message: message)
        log(model: model)
    }
    
    public func error(message: String) {
        let model = LogModel(type: .error, message: message)
        log(model: model)
    }
    
    public func error(error: Error) {
        let model = LogModel(type: .error, message: error.localizedDescription)
        log(model: model)
    }
}

// MARK: - Private
private extension LogServiceImpl {
    func log(model: LogModel) {
        debugPrint("\(Date()) ::\(model.type):: LOG: \(model.logMessage)")
    }
}


//
//  StorageManager.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation
import SwiftData
import Combine

/**
 A protocol for managing persistent data storage using SwiftData.
 
 The `StorageManager` protocol defines a unified interface for performing asynchronous CRUD (Create, Read, Update, Delete)
 operations on persistent models. It exposes a `ModelContainer` that manages the underlying persistent store and a Combine
 publisher that emits notifications whenever the main context changes. All operations are expected to be performed on the main thread.
 
 - Note: The Combine publisher `contextChangedPublisher` is triggered after changes are saved in the main context.
 */

protocol StorageManager: ObservableObject {
    // MARK: - Properties
    
    /// The model container managing the persistent store.
    var container: ModelContainer { get }
    
    /// A publisher that emits an event whenever the main context changes.
    var contextChangedPublisher: AnyPublisher<Void, Never> { get }
    
    // MARK: - Funcs
    
    /// Inserts a new persistent model into the main context.
    func create(model: any PersistentModel) async
    
    
    /// Fetches all persistent models of the specified type from the main context.
    ///
    /// - Parameters:
    ///   - type: The type of model to fetch.
    ///   - sorts: An array of sort descriptors used to order the results.
    ///   - limit: An optional limit for the number of models to fetch.
    ///   - Returns: An array of models of the specified type.
    func fetchAll<T: PersistentModel>(
        _ type: T.Type,
        sorts: [SortDescriptor<T>],
        limit: Int?
    ) async -> [T]
    
    /// Updates an existing persistent model in the main context.
    func update(model: any PersistentModel) async
    
    /// Deletes a persistent model from the main context.
    func delete(model: any PersistentModel) async
}

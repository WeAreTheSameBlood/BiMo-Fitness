//
//  StorageManager.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation
import SwiftData
import Combine

final class StorageManagerImpl: StorageManager {
    // MARK: - Publishers
    private(set) lazy var contextChangedPublisher = contextChangedSubject.eraseToAnyPublisher()
    private let contextChangedSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - Properties
    let container: ModelContainer
    
    // MARK: - Init
    init() {
        let schema = Schema([Workout.self, Exercise.self])
        
        let modelConfiguration = ModelConfiguration(
            /// Array of Models entities
            schema: schema,
            
            /// Save data on ROM
            isStoredInMemoryOnly: false,
            
            /// Allow save changes in model (one obj from scjema)
            allowsSave: true
        )
        
        do {
            self.container = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}

// MARK: - CRUD
extension StorageManagerImpl {
    @MainActor func create(model: any PersistentModel) {
        container.mainContext.insert(model)
        saveContext()
    }
    
    @MainActor func fetchAll<T>(
        _ type: T.Type,
        sorts: [SortDescriptor<T>] = [],
        limit: Int? = nil
    ) async -> [T] where T: PersistentModel {
        var descriptor = FetchDescriptor<T>(sortBy: sorts)
        descriptor.fetchLimit = limit
        
        do {
            return try container.mainContext.fetch(descriptor)
        } catch {
            return []
        }
    }
    
    @MainActor func update(model: any PersistentModel) {
        /// Use mainContext.insert(model) with unique param
        /// Rewrite current object in container
        self.create(model: model)
    }
    
    @MainActor func delete(model: any PersistentModel) {
        container.mainContext.delete(model)
        saveContext()
    }
}

// MARK: - Private
private extension StorageManagerImpl {
    @MainActor func saveContext() {
        do {
            try container.mainContext.save()
            self.contextChangedSubject.send()
        } catch {
            log.error(message: "Could not save context: \(error)")
        }
    }
}

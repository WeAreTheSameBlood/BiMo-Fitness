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

// MARK: - SeedDeafault
extension StorageManagerImpl {
  @MainActor
  func seedDefaultExercises() async {
    let existing: [Exercise] = await fetchAll(Exercise.self)
//    guard existing.isEmpty else { return }
    
    let defaults: [Exercise] = [
        Exercise(name: "Squat", muscleGroups: [MuscleGroup.legs.rawValue]),
        Exercise(name: "Front Squat", muscleGroups: [MuscleGroup.legs.rawValue]),
        Exercise(name: "Deadlift", muscleGroups: [
            MuscleGroup.back.rawValue,
            MuscleGroup.legs.rawValue
        ]),
        Exercise(name: "Bench Press", muscleGroups: [
            MuscleGroup.chest.rawValue,
            MuscleGroup.arms.rawValue
        ]),
        Exercise(name: "Incline Bench Press", muscleGroups: [
            MuscleGroup.chest.rawValue,
            MuscleGroup.arms.rawValue
        ]),
        Exercise(name: "Overhead Press", muscleGroups: [
            MuscleGroup.shoulders.rawValue,
            MuscleGroup.arms.rawValue
        ]),
        Exercise(name: "Pull-up", muscleGroups: [
            MuscleGroup.back.rawValue,
            MuscleGroup.arms.rawValue
        ]),
        Exercise(name: "Chin-up", muscleGroups: [
            MuscleGroup.back.rawValue,
            MuscleGroup.arms.rawValue
        ]),
        Exercise(name: "Barbell Row", muscleGroups: [
            MuscleGroup.back.rawValue,
            MuscleGroup.arms.rawValue
        ]
                ),
        Exercise(name: "Pendlay Row", muscleGroups: [
            MuscleGroup.back.rawValue,
            MuscleGroup.arms.rawValue
        ]),
        Exercise(name: "Lat Pulldown", muscleGroups: [
            MuscleGroup.back.rawValue,
            MuscleGroup.arms.rawValue
        ]),
        Exercise(name: "Dumbbell Curl", muscleGroups: [MuscleGroup.arms.rawValue]),
        Exercise(name: "Triceps Extension", muscleGroups: [MuscleGroup.arms.rawValue]),
        Exercise(name: "Hammer Curl", muscleGroups: [MuscleGroup.arms.rawValue]),
        Exercise(name: "Lateral Raise", muscleGroups: [MuscleGroup.shoulders.rawValue]),
        Exercise(name: "Face Pull", muscleGroups: [
            MuscleGroup.shoulders.rawValue,
            MuscleGroup.back.rawValue
        ]),
        Exercise(name: "Leg Press", muscleGroups: [MuscleGroup.legs.rawValue]),
        Exercise(name: "Leg Extension", muscleGroups: [MuscleGroup.legs.rawValue]),
        Exercise(name: "Leg Curl", muscleGroups: [MuscleGroup.legs.rawValue]),
        Exercise(name: "Calf Raise", muscleGroups: [MuscleGroup.legs.rawValue]),
        Exercise(name: "Hip Thrust", muscleGroups: [MuscleGroup.legs.rawValue]),
        Exercise(name: "Bulgarian Split Squat", muscleGroups: [
            MuscleGroup.legs.rawValue,
        ]),
        Exercise(name: "Romanian Deadlift", muscleGroups: [
            MuscleGroup.legs.rawValue,
            MuscleGroup.back.rawValue
        ]),
        Exercise(name: "Good Morning", muscleGroups: [
            MuscleGroup.back.rawValue,
            MuscleGroup.legs.rawValue
        ]),
        Exercise(name: "Chest Fly", muscleGroups: [MuscleGroup.chest.rawValue,]),
        Exercise(name: "Cable Crossover", muscleGroups: [MuscleGroup.chest.rawValue]),
        Exercise(name: "Dips", muscleGroups: [
            MuscleGroup.chest.rawValue,
            MuscleGroup.arms.rawValue
        ]),
        Exercise(name: "Seated Row", muscleGroups: [
            MuscleGroup.back.rawValue, 
            MuscleGroup.arms.rawValue
        ]),
        Exercise(name: "Shrug", muscleGroups: [
            MuscleGroup.shoulders.rawValue,
            MuscleGroup.back.rawValue
        ]),
        Exercise(name: "Farmer's Walk", muscleGroups: [
            MuscleGroup.back.rawValue,
            MuscleGroup.legs.rawValue
        ]),
        Exercise(name: "Reverse Fly", muscleGroups: [
            MuscleGroup.shoulders.rawValue,
            MuscleGroup.back.rawValue
        ]),
        Exercise(name: "Arnold Press", muscleGroups: [
            MuscleGroup.shoulders.rawValue,
            MuscleGroup.arms.rawValue
        ]),
        Exercise(name: "Preacher Curl", muscleGroups: [MuscleGroup.arms.rawValue]),
        Exercise(name: "Skullcrusher", muscleGroups: [MuscleGroup.arms.rawValue]),
        Exercise(name: "Plank", muscleGroups: [MuscleGroup.abs.rawValue]),
        Exercise(name: "Mountain Climber", muscleGroups: [
            MuscleGroup.abs.rawValue,
            MuscleGroup.legs.rawValue
        ]),
        Exercise(name: "Push-up", muscleGroups: [
            MuscleGroup.chest.rawValue,
            MuscleGroup.arms.rawValue
        ]),
        Exercise(name: "Close-Grip Bench Press", muscleGroups: [
            MuscleGroup.chest.rawValue,
            MuscleGroup.arms.rawValue
        ])
    ]
    for ex in defaults { create(model: ex) }
  }
}

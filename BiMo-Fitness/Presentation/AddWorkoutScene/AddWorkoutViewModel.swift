//
//  AddWorkoutViewModel.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation
import SwiftUI

final class AddWorkoutViewModel: BaseViewModel {
    // MARK: - Properties
    @Published var exercises: [Exercise] = []
    @Published var selectedExercises: [Exercise] = []
    
    // MARK: - Services
    private var storageManager: (any StorageManager)?

    // MARK: - Setup
    func setup(_ storageManager: any StorageManager) {
        self.storageManager = storageManager
        setupBinding()
    }

    // MARK: - Toggle
    func toggle(_ exercise: Exercise) {
        if selectedExercises.contains(where: { $0.id == exercise.id }) {
            selectedExercises.removeAll { $0.id == exercise.id }
        } else {
            selectedExercises.append(exercise)
        }
    }
    
    // MARK: - Funcs
    func createNewWorkout(dismiss: DismissAction) {
        Task {
            await createWorkout()
            await dismiss()
        }
    }
}

// MARK: - Private
private extension AddWorkoutViewModel {
    func setupBinding() {
        guard let storageManager else { return }
        storageManager.contextChangedPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.fetchExercises()
            }
            .store(in: &cancellables)
    }
    
    func fetchExercises() {
        guard let storageManager else { return }
        Task { @MainActor in
            exercises = await storageManager.fetchAll(
                Exercise.self,
                sorts: [SortDescriptor(\Exercise.name)],
                limit: nil
            )
        }
    }
    
    func createWorkout() async {
        guard let storageManager else { return }
        let newWorkout = Workout(
            name: "workoutName",
            exercises: selectedExercises
        )
        await storageManager.create(model: newWorkout)
    }
}

//
//  AddWorkoutViewModel.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation

final class AddWorkoutViewModel: ObservableObject {
    // MARK: - Properties
    @Published var exercises: [Exercise] = []
    @Published var selected: [Exercise] = []
    private let exerciseManager: ExerciseManager

    // MARK: - Init
    init(service: ExerciseManager) {
        self.exerciseManager = service
        service.fetchExercises()
            .receive(on: DispatchQueue.main)
            .assign(to: &$exercises)
    }

    // MARK: - Toggle
    func toggle(_ ex: Exercise) {
        if selected.contains(where: { $0.id == ex.id }) {
            selected.removeAll { $0.id == ex.id }
        } else {
            selected.append(ex)
        }
    }
}

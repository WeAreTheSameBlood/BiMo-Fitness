//
//  WorkoutDetailsViewModel.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation

final class WorkoutDetailsViewModel: BaseViewModel {
    // MARK: - Properties
    @Published var workout: Workout
    
    // MARK: - Init
    init(workout: Workout) {
        self.workout = workout
    }
}

// MARK: - Private
private extension WorkoutDetailsViewModel {
    
}

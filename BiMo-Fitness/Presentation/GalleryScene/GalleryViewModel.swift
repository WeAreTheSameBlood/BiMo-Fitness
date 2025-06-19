//
//  GalleryViewModel.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation

final class GalleryViewModel: ObservableObject {
    // MARK: - Properties
    @Published var workouts: [Workout] = []
    private let workoutManager: WorkoutManager

    // MARK: - Init
    init(service: WorkoutManager) {
        self.workoutManager = service
        service.fetchWorkouts()
            .receive(on: DispatchQueue.main)
            .assign(to: &$workouts)
    }
}

// MARK: - Private
private extension GalleryViewModel {
    
}

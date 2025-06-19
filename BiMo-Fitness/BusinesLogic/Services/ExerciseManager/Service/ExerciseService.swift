//
//  ExerciseService.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation
import Combine

class ExerciseService: ExerciseManager {
    func fetchExercises() -> AnyPublisher<[Exercise], Never> {
        Just([
            Exercise(id: .init(), name: "Push-up"),
            Exercise(id: .init(), name: "Squat"),
            Exercise(id: .init(), name: "Plank")
        ]).eraseToAnyPublisher()
    }
}

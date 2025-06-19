//
//  WorkoutService.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation
import Combine

class WorkoutService: WorkoutManager {
    func fetchWorkouts() -> AnyPublisher<[Workout], Never> {
        Just([
            Workout(id: .init(), name: "Chest Day"),
            Workout(id: .init(), name: "Leg Day")
        ]).eraseToAnyPublisher()
    }
}

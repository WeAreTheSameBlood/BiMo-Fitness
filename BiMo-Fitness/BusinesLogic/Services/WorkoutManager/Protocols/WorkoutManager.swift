//
//  WorkoutManager.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation
import Combine

protocol WorkoutManager {
    func fetchWorkouts() -> AnyPublisher<[Workout], Never>
}

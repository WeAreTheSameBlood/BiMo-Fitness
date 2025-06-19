//
//  Exercise.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation
import SwiftData

@Model
class Exercise: Identifiable {
    // MARK: - Properties
    @Attribute(.unique) var id: UUID
    var name: String
    var muscleGroups: [String]
    
    var workouts: [Workout] = []
    
    // MARK: - Init
    init(
        id: UUID = .init(),
        name: String,
        muscleGroups: [String]
    ) {
        self.id = id
        self.name = name
        self.muscleGroups = muscleGroups
    }
}

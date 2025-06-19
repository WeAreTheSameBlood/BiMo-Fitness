//
//  Workout.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation
import SwiftData

@Model
class Workout: Identifiable {
    // MARK: - Properties
    @Attribute(.unique) var id: UUID
    var name: String
    var dateCreated: Date
    
    @Relationship(inverse: \Exercise.workouts)
    var exercises: [Exercise] = []
    
    // MARK: - Init
    init(
        id: UUID = .init(),
        name: String,
        dateCreated: Date = .init(),
        exercises: [Exercise] = []
    ) {
        self.id = id
        self.name = name
        self.dateCreated = dateCreated
        self.exercises = exercises
    }
}

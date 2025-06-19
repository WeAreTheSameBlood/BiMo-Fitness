//
//  MuscleGroup.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation

enum MuscleGroup: String, CaseIterable, Identifiable {
    case arms = "Arms"
    case legs = "Legs"
    case chest = "Chest"
    case back = "Back"
    case shoulders = "Shoulders"
    case abs = "Abs"
    case cardio = "Cardio"
    
    var id: String { rawValue }
}

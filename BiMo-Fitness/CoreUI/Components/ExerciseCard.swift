//
//  ExerciseCard.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation
import SwiftUI

struct ExerciseCard: View {
    // MARK: - Properties
    let exercise: Exercise
    let isSelected: Bool

    // MARK: - Body
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    isSelected ? .blue : .gray,
                    lineWidth: isSelected ? 3 : 1)
            Text(exercise.name).padding()
        }
        .frame(height: 100)
    }
}

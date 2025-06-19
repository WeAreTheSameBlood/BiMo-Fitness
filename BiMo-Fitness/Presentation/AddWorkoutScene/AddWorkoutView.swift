//
//  AddWorkoutView.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import SwiftUI

struct AddWorkoutView: View {
    // MARK: - Properties
    @StateObject var viewModel: AddWorkoutViewModel
    private let cardGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            LazyVGrid(columns: cardGrid, spacing: 16) {
                ForEach(viewModel.exercises) { exercise in
                    ExerciseCard(
                        exercise: exercise,
                        isSelected: viewModel.selected.contains { $0.id == exercise.id }
                    )
                    .onTapGesture { viewModel.toggle(exercise) }
                }
            }
            .padding()
        }
        .navigationTitle("Add Workout")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") { }
            }
        }
    }
}

//#Preview {
//    AddWorkoutView()
//}

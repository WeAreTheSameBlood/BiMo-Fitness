//
//  AddWorkoutView.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import SwiftUI

struct AddWorkoutView: View {
    // MARK: - Environments
    @EnvironmentObject private var storageManager: StorageManagerImpl
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Properties
    @StateObject var viewModel = AddWorkoutViewModel()
    @State private var selectedGroup: MuscleGroup? = nil
    @Namespace private var animation
    private let cardGrid = [GridItem(.flexible()), GridItem(.flexible())]
    private var exercisesForGroup: [Exercise] {
        guard let selectedGroup else { return [] }
        return viewModel.exercises.filter { $0.muscleGroups.contains(selectedGroup.rawValue) }
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            if let group = selectedGroup {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemBackground))
                    .matchedGeometryEffect(id: group.rawValue, in: animation)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVGrid(columns: cardGrid, spacing: 16) {
                        ForEach(exercisesForGroup) { (exercise) in
                            ExerciseCard(
                                exercise: exercise,
                                isSelected: viewModel.selectedExercises.contains { $0.id == exercise.id }
                            )
                            .onTapGesture { viewModel.toggle(exercise) }
                        }
                    }
                    .padding()
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: cardGrid, spacing: 16) {
                        ForEach(MuscleGroup.allCases) { (group) in
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray)
                                    .matchedGeometryEffect(id: group.rawValue, in: animation)
                                
                                Text(group.rawValue)
                                    .frame(maxWidth: .infinity, minHeight: 80)
                            }
                            .onTapGesture {
                                withAnimation(.spring()) { selectedGroup = group }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(selectedGroup?.rawValue ?? "Add Workout")
        .toolbar {
            saveButtonToolbar
            ToolbarItem(placement: .navigationBarTrailing) {
                if selectedGroup != nil {
                    Button("Save") { }
                }
            }
        }
        .onAppear { viewModel.setup(storageManager) }
    }
}

// MARK: - Private
private extension AddWorkoutView {
    var saveButtonToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Save") {
                viewModel.createNewWorkout(dismiss: dismiss)
            }
        }
    }
}

//#Preview {
//    AddWorkoutView()
//}

//
//  GalleryView.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import SwiftUI

struct GalleryView: View {
    // MARK: - Properties
    @StateObject var vm = GalleryViewModel(service: WorkoutService())
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List(vm.workouts) { (workout) in
                NavigationLink(workout.name) {
                    WorkoutDetailsView(viewModel: .init(workout: workout))
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Add") {
                        AddWorkoutView(viewModel: .init(service: ExerciseService()))
                    }
                }
            }
        }
    }
}

#Preview {
    GalleryView()
}

//
//  GalleryView.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import SwiftUI

struct GalleryView: View {
    // MARK: - Environments
    @EnvironmentObject private var storageManager: StorageManagerImpl
    
    // MARK: - Properties
    @StateObject var viewModel = GalleryViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List(viewModel.workouts) { (workout) in
                NavigationLink(workout.name) {
                    WorkoutDetailsView(viewModel: .init(workout: workout))
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Add") {
                        AddWorkoutView()
                    }
                }
            }
        }
        .onAppear { viewModel.setup(storageManager) }
    }
}

#Preview {
    GalleryView()
}

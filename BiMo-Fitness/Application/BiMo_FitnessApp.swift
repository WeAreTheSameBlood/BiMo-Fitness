//
//  BiMo_FitnessApp.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import SwiftUI
import SwiftData

@main
struct BiMo_FitnessApp: App {
    // MARK: - Properties
    @StateObject private var workoutManager = WorkoutServiceImpl()
    @StateObject private var storageManager = StorageManagerImpl()

    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            GalleryView()
                .environmentObject(workoutManager)
                .environmentObject(storageManager)
        }
    }
}

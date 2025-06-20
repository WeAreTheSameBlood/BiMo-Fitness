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
    @StateObject private var storageManager = StorageManagerImpl()
    
    // MARK: - Init
    init() {
        defaultCheck()
    }
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            GalleryView()
                .environmentObject(storageManager)
        }
    }
}

// MARK: - Private
private extension BiMo_FitnessApp {
    func defaultCheck() {
        if !UserDefaults.standard.didSeedData {
            Task { @MainActor in
                await self.storageManager.seedDefaultExercises()
                UserDefaults.standard.didSeedData = true
            }
        }
    }
}

//
//  GalleryViewModel.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Foundation

final class GalleryViewModel: BaseViewModel {
    // MARK: - Properties
    @Published var workouts: [Workout] = []
    
    // MARK: - Services
    private var storageManager: (any StorageManager)?
    
    // MARK: - Setup
    func setup(_ storageManager: any StorageManager) {
        self.storageManager = storageManager
        setupBinding()
    }
}

// MARK: - Private
private extension GalleryViewModel {
    func setupBinding() {
        guard let storageManager else { return }
        storageManager.contextChangedPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.fetchWorkouts()
            }
            .store(in: &cancellables)
    }
    
    func fetchWorkouts() {
        guard let storageManager else { return }
        Task { @MainActor in
            workouts = await storageManager.fetchAll(
                Workout.self,
                sorts: [SortDescriptor(\Workout.dateCreated)],
                limit: nil
            )
        }
    }
}

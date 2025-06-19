//
//  BaseViewModel.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import Combine

class BaseViewModel: ObservableObject {
    // MARK: - Cancellables
    var cancellables: Set<AnyCancellable> = []
}

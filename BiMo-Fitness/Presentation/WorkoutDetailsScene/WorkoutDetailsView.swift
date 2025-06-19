//
//  WorkoutDetailsView.swift
//  BiMo-Fitness
//
//  Created by Andrii Hlybchenko on 19.06.2025.
//

import SwiftUI

struct WorkoutDetailsView: View {
    // MARK: - Properties
    @StateObject var viewModel: WorkoutDetailsViewModel
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text(viewModel.workout.name)
                .font(.largeTitle)
        }
        .navigationTitle("Details")
    }
}

//#Preview {
//    WorkoutDetailsView()
//}

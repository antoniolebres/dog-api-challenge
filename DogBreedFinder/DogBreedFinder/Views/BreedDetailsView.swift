//
//  BreedDetailsView.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import SwiftUI

struct BreedDetailsView: View {

    @ObservedObject private var viewModel: BreedDetailsViewModel

    init(viewModel: BreedDetailsViewModel) {

        self.viewModel = viewModel
    }

    var body: some View {

        Text("Breed: \(self.viewModel.breed.name)")
    }
}

#Preview {
    BreedDetailsView(viewModel: .init(breed: DummyData.breeds[0]))
}

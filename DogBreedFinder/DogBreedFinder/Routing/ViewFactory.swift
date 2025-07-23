//
//  ViewFactory.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import SwiftUI

class ViewFactory {

    let dogBreedRepository: DogBreedRepository

    init(dogBreedRepository: DogBreedRepository) {

        self.dogBreedRepository = dogBreedRepository
    }

    @ViewBuilder
    func buildView(for route: Route) -> some View {

        switch route {

        case .breedDetails(let breed):
            BreedDetailsView(viewModel: .init(breed: breed))

        case .breeds:
            BreedImagesView(viewModel: .init(dogBreedRepository: self.dogBreedRepository))

        case .search:
            BreedSearchView()
        }
    }
}

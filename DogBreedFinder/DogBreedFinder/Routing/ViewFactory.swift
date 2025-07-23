//
//  ViewFactory.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import SwiftUI

class ViewFactory {

    @ViewBuilder
    static func buildView(for route: Route) -> some View {

        switch route {

        case .breedDetails(let breed):
            BreedDetailsView(viewModel: BreedDetailsViewModel(breed: breed))

        case .breeds:
            BreedImagesView()

        case .search:
            BreedSearchView()
        }
    }
}

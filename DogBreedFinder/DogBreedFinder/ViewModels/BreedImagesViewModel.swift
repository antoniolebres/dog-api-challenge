//
//  BreedImagesViewModel.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

import Foundation
import UIKit

enum ViewPresentationType: String, CaseIterable {

    case grid = "Grid"
    case list = "List"

    var systemIconName: String {

        switch self {

        case .grid:
            "square.grid.2x2"

        case .list:
            "list.bullet"
        }
    }
}

class BreedImagesViewModel: ObservableObject {

    @Published var selectedPresentationType: ViewPresentationType = UIDevice.isPad ? .grid : .list
    @Published var breeds: [Breed] = []

    private let dogBreedRepository: DogBreedRepository

    init(dogBreedRepository: DogBreedRepository) {

        self.dogBreedRepository = dogBreedRepository
    }

    @MainActor
    func getBreeds() async {

        // TODO: Consider the use of states to handle pagination and errors

        do {

            // TODO: Handle pagination
            self.breeds = try await self.dogBreedRepository.getBreeds(page: 0)

        } catch {

            print("Error: \(error)")
        }
    }
}

// MARK: - Actions

extension BreedImagesViewModel {

    func didTapSortAlphabeticallyAscending() {

    }

    func didTapSortAlphabeticallyDescending() {

    }
}

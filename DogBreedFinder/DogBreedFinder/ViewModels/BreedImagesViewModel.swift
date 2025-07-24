//
//  BreedImagesViewModel.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

import Foundation
import UIKit

enum BreedsPresentationType: String, CaseIterable {

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

    @Published var selectedPresentationType: BreedsPresentationType = UIDevice.isPad ? .grid : .list
    @Published var breeds: [Breed] = []

    var shouldRequestBreeds: Bool {

        self.hasTriggeredInitialRequest == false
    }

    private var hasTriggeredInitialRequest = false
    private let dogBreedRepository: DogBreedRepository

    init(dogBreedRepository: DogBreedRepository) {

        self.dogBreedRepository = dogBreedRepository
    }

    @MainActor
    func getBreeds() async {

        // TODO: Consider the use of states to handle pagination and errors

        do {

            // TODO: Handle pagination
            let breeds = try await self.dogBreedRepository.getBreeds(page: 0)

            self.breeds = breeds
            self.hasTriggeredInitialRequest = true

        } catch {

            print("Error: \(error)")
        }
    }
}

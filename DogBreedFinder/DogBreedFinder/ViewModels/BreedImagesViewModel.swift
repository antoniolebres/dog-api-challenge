//
//  BreedImagesViewModel.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

import Foundation

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

    @Published var pickerSelection: ViewPresentationType = .grid
    @Published var breeds: [Breed] = []

    func getBreedImages() {

        // TODO: Implement this after adding the proper API implementation

        Task { @MainActor in

            do {

                try await Task.sleep(for: .seconds(2))
                self.breeds = DummyData.breeds

            } catch {

                print("Error: \(error)")
            }
        }
    }
}

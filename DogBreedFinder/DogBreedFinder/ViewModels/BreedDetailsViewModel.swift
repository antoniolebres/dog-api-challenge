//
//  BreedDetailsViewModel.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import Foundation

class BreedDetailsViewModel: ObservableObject {

    let breed: Breed

    init(breed: Breed) {

        self.breed = breed
    }

    var breedOrigin: String? {

        if let origin = self.breed.origin,
           origin.isEmpty == false {

            return origin
        }

        if let countryCode = self.breed.countryCode {

            return self.countryName(for: countryCode)
        }

        if let countryCodes = self.breed.countryCodes {

            return countryCodes
                .compactMap { self.countryName(for: $0) }
                .joined(separator: ", ")
        }

        return nil
    }
}

// MARK: - Private

private extension BreedDetailsViewModel {

    // TODO: Move outside of VM - Single Responsibility Principle
    func countryName(for countryCode: String) -> String? {

        guard countryCode.isEmpty == false else {

            return nil
        }

        return Locale.current.localizedString(forRegionCode: countryCode)
    }
}

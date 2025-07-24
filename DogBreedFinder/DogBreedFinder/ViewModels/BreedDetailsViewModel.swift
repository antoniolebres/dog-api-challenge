//
//  BreedDetailsViewModel.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import Foundation

class BreedDetailsViewModel {

    let breed: Breed

    var breedDetailSections: [BreedDetailsSectionConfiguration] {

        BreedDetailsSectionFactory.buildSections(from: self.breed)
    }

    init(breed: Breed) {

        self.breed = breed
    }
}

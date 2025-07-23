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
}

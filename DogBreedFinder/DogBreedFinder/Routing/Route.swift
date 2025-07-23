//
//  Route.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import SwiftUI

enum Route: Hashable {

    case breeds
    case breedDetails(breed: Breed)
    case search
}

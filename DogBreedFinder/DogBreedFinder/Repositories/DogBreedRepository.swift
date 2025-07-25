//
//  DogBreedRepository.swift
//  DogBreedFinder
//
//  Created by António Lebres on 23/07/2025.
//

import Foundation

enum DogBreedRepositorySortOption {

    case ascending
    case descending
}

protocol DogBreedRepository: AnyObject {

    func getBreeds(page: Int, pageSize: Int, order: DogBreedRepositorySortOption) async throws -> [Breed]
    func searchBreeds(query: String) async throws -> [Breed]
}

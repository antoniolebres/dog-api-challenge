//
//  DogBreedRepository.swift
//  DogBreedFinder
//
//  Created by António Lebres on 23/07/2025.
//

import Foundation

protocol DogBreedRepository: AnyObject {

    func getBreeds(page: Int) async throws -> [Breed]
    func searchBreeds(query: String) async throws -> [Breed]
}

//
//  Breed.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

struct Breed: Identifiable, Decodable, Hashable {

    let id: Int
    let name: String
    let temperament: String?
    let origin: String?
    let countryCode: String?
    let countryCodes: [String]?
    let breedGroup: String?
    let image: BreedImage?
}

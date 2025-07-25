//
//  Breed.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

struct Breed: Identifiable, Decodable, Hashable {

    enum CodingKeys: String, CodingKey {

        case id
        case name
        case temperament
        case origin
        case countryCode = "country_code"
        case countryCodes = "country_codes"
        case breedGroup = "breed_group"
        case image
    }

    let id: Int
    let name: String
    let temperament: String?
    let origin: String?
    let countryCode: String?
    let countryCodes: [String]?
    let breedGroup: String?
    let image: BreedImage?

    var breedOrigin: String? {

        if let origin = self.origin,
           origin.isEmpty == false {

            return origin
        }

        if let countryCode = self.countryCode {

            return CountryHelper.countryName(for: countryCode)
        }

        if let countryCodes = self.countryCodes {

            return countryCodes
                .compactMap { CountryHelper.countryName(for: $0) }
                .joined(separator: ", ")
        }

        return nil
    }
}

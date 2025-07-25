//
//  DummyData.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

#if DEBUG

import Foundation

class DummyRepository: DogBreedRepository {

    func getBreeds(page: Int, pageSize: Int, order: DogBreedRepositorySortOption) async throws -> [Breed] {

        // Simulating network request
        try await Task.sleep(for: .seconds(1))

        return DummyData.breeds
    }
    
    func searchBreeds(query: String) async throws -> [Breed] {

        // Simulating network request
        try await Task.sleep(for: .seconds(1))

        return DummyData.breeds.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
}

class DummyData {

    static func image() -> BreedImage {

        let imageURL = Bundle.main.url(forResource: ["test", "test2"].randomElement()!, withExtension: "jpg")

        return .init(id: "a1b2c3", width: 1024, height: 60, urlString: imageURL?.absoluteString)
    }

    static let breeds: [Breed] = [
        .init(
            id: 12,
            name: "American Eskimo Dog",
            temperament: "Wild, Hardworking, Dutiful",
            origin: "France",
            countryCode: nil,
            countryCodes: nil,
            breedGroup: "Non-Sporting",
            image: DummyData.image()
        ),
        .init(
            id: 10,
            name: "Akita",
            temperament: "Wild, Hardworking, Dutiful",
            origin: "",
            countryCode: nil,
            countryCodes: nil,
            breedGroup: "",
            image: DummyData.image()
        ),
        .init(
            id: 15,
            name: "African Hunting Dog",
            temperament: "Wild, Hardworking, Dutiful",
            origin: "",
            countryCode: "AG",
            countryCodes: nil,
            breedGroup: "",
            image: DummyData.image()
        ),
        .init(
            id: 1,
            name: "Affenpinscher",
            temperament: "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving",
            origin: "Germany, France",
            countryCode: nil,
            countryCodes: nil,
            breedGroup: "Toy",
            image: DummyData.image()
        ),
        .init(
            id: 2,
            name: "Afghan Hound",
            temperament: "Aloof, Clownish, Dignified, Independent, Happy",
            origin: "Afghanistan, Iran, Pakistan",
            countryCode: nil,
            countryCodes: nil,
            breedGroup: "Hound",
            image: DummyData.image()
        ),
        .init(
            id: 3,
            name: "African Hunting Dog 2",
            temperament: "Wild, Hardworking, Dutiful",
            origin: "",
            countryCode: nil,
            countryCodes: ["AO", "BW"],
            breedGroup: "",
            image: DummyData.image()
        ),
        .init(
            id: 4,
            name: "Alapaha Blue Blood Bulldog",
            temperament: "Wild, Hardworking, Dutiful",
            origin: "",
            countryCode: nil,
            countryCodes: nil,
            breedGroup: "",
            image: DummyData.image()
        ),
        .init(
            id: 5,
            name: "Alaskan Husky",
            temperament: "Wild, Hardworking, Dutiful",
            origin: "",
            countryCode: nil,
            countryCodes: nil,
            breedGroup: "",
            image: DummyData.image()
        ),
        .init(
            id: 6,
            name: "Alaskan Malamute",
            temperament: "Wild, Hardworking, Dutiful",
            origin: "",
            countryCode: nil,
            countryCodes: nil,
            breedGroup: "",
            image: DummyData.image()
        ),
        .init(
            id: 7,
            name: "American Bulldog",
            temperament: "Wild, Hardworking, Dutiful",
            origin: "",
            countryCode: nil,
            countryCodes: nil,
            breedGroup: "",
            image: DummyData.image()
        ),
        .init(
            id: 8,
            name: "Airedale Terrier",
            temperament: "Wild, Hardworking, Dutiful",
            origin: "",
            countryCode: nil,
            countryCodes: nil,
            breedGroup: "",
            image: DummyData.image()
        ),
        .init(
            id: 9,
            name: "AAkbash Dog",
            temperament: "Wild, Hardworking, Dutiful",
            origin: "",
            countryCode: nil,
            countryCodes: nil,
            breedGroup: "",
            image: DummyData.image()
        ),
        .init(
            id: 11,
            name: "American Bully",
            temperament: "Wild, Hardworking, Dutiful",
            origin: "",
            countryCode: nil,
            countryCodes: nil,
            breedGroup: "",
            image: DummyData.image()
        )
    ]
}

#endif

//
//  DummyData.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

#if DEBUG

class DummyData {

    static let image: BreedImage = .init(id: "a1b2c3", width: 1024, height: 60, urlString: nil)

    static let breeds: [Breed] = [
        .init(id: 1, name: "Affenpinscher", temperament: "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving", origin: "Germany, France", breedGroup: "Toy", image: DummyData.image),
        .init(id: 2, name: "Afghan Hound", temperament: "Aloof, Clownish, Dignified, Independent, Happy", origin: "Afghanistan, Iran, Pakistan", breedGroup: "Hound", image: DummyData.image),
        .init(id: 3, name: "African Hunting Dog", temperament: "Wild, Hardworking, Dutiful", origin: "", breedGroup: "", image: DummyData.image),
        .init(id: 4, name: "Alapaha Blue Blood Bulldog", temperament: "Wild, Hardworking, Dutiful", origin: "", breedGroup: "", image: DummyData.image)
    ]
}

#endif

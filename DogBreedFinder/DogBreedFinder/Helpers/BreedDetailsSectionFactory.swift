//
//  BreedDetailsSectionFactory.swift
//  DogBreedFinder
//
//  Created by António Lebres on 24/07/2025.
//

struct BreedDetailsSectionConfiguration {

    let title: String
    let description: String
    let systemIconName: String
}

enum BreedDetailsSectionFactory {

    static func buildSections(from breed: Breed) -> [BreedDetailsSectionConfiguration] {

        var sections: [BreedDetailsSectionConfiguration] = []

        if let group = breed.breedGroup,
           group.isEmpty == false {

            sections.append(
                .init(
                    title: "Group",
                    description: group,
                    systemIconName: "rectangle.3.group"
                )
            )
        }

        if let origin = breed.breedOrigin {

            sections.append(
                .init(
                    title: "Origin",
                    description: origin,
                    systemIconName: "house.fill"
                )
            )
        }

        if let temperament = breed.temperament,
           temperament.isEmpty == false {

            sections.append(
                .init(
                    title: "Temperament",
                    description: temperament,
                    systemIconName: "heart.fill"
                )
            )
        }

        return sections
    }
}

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

        if let origin = Self.breedOrigin(from: breed) {

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

// MARK: - Private

private extension BreedDetailsSectionFactory {

    static func breedOrigin(from breed: Breed) -> String? {

        if let origin = breed.origin,
           origin.isEmpty == false {

            return origin
        }

        if let countryCode = breed.countryCode {

            return CountryHelper.countryName(for: countryCode)
        }

        if let countryCodes = breed.countryCodes {

            return countryCodes
                .compactMap { CountryHelper.countryName(for: $0) }
                .joined(separator: ", ")
        }

        return nil
    }
}

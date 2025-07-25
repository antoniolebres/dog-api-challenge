//
//  DogBreedFinderAppTab.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

enum DogBreedFinderAppTab: String, CaseIterable {

    case breeds = "Breeds"
    case search = "Search"

    var systemImageName: String {

        switch self {

        case .breeds:
            "dog"

        case .search:
            "magnifyingglass"
        }
    }

    var baseRoute: Route {

        switch self {

        case .breeds:
            .breeds

        case .search:
            .search
        }
    }
}

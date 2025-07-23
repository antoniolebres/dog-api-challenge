//
//  DogAPIRepository.swift
//  DogBreedFinder
//
//  Created by António Lebres on 23/07/2025.
//

import Foundation

enum DogAPIResource: BaseRequestResource {

    private enum Constants {

        static let pageSize = 20
    }

    case getBreeds(page: Int)
    case searchBreeds(query: String)

    var path: String {

        switch self {

        case .getBreeds:
            "breeds"

        case .searchBreeds:
            "breeds/search"
        }
    }

    var queryItems: [URLQueryItem] {

        switch self {

        case .getBreeds(let page):
            return [
                .init(name: "page", value: page.description),
                .init(name: "limit", value: Constants.pageSize.description)
            ]

        case .searchBreeds(let query):
            return [.init(name: "q", value: query)]
        }
    }

    var method: HTTPMethod {

        switch self {

        case .getBreeds,
                .searchBreeds:
            return .get
        }
    }

    var body: Encodable? {

        switch self {

        case .getBreeds,
                .searchBreeds:

            return nil
        }
    }
}

class DogAPIRepository: BaseRepository<DogAPIResource>, DogBreedRepository {

    private enum Constants {

        static let baseURLString = "api.thedogapi.com/v1/"
    }

    init() {

        super.init(baseURL: Constants.baseURLString)
    }

    func getBreeds(page: Int) async throws -> [Breed] {

        try await self.request(resource: .getBreeds(page: page))
    }
    
    func searchBreeds(query: String) async throws -> [Breed] {

        try await self.request(resource: .searchBreeds(query: query))
    }
}

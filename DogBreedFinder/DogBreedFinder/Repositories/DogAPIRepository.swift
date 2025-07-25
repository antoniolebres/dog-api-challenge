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

    case getBreeds(page: Int,
                   pageSize: Int = Constants.pageSize,
                   order: DogBreedRepositorySortOption = .ascending)

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

        case .getBreeds(let page, let pageSize, let sortOption):
            return [
                .init(name: "page", value: page.description),
                .init(name: "limit", value: pageSize.description),
                .init(name: "order", value: Self.sortOption(from: sortOption))
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

    private static func sortOption(from option: DogBreedRepositorySortOption) -> String {

        switch option {

        case .ascending:
            "ASC"

        case .descending:
            "DESC"
        }
    }
}

struct DogAPIRepositoryConfiguration {

    private enum Constants {

        static let baseURLString = "https://api.thedogapi.com/v1/"
        static let dogAPIKeyBundleKey = "DOG_API_KEY"
    }

    let baseURLString: String
    let apiKey: String

    // Only for demo purposes
    static let defaultConfiguration: DogAPIRepositoryConfiguration = .init(
        baseURLString: Constants.baseURLString,
        apiKey: Bundle.main.infoDictionary?[Constants.dogAPIKeyBundleKey] as? String ?? "Unknown"
    )
}

class DogAPIRepository: BaseRepository<DogAPIResource>, DogBreedRepository {

    private enum Constants {

        static let authorizationHeaderField = "x-api-key"
    }

    private lazy var authorizationHeader: [String: String] = {

        return [Constants.authorizationHeaderField : self.configuration.apiKey]
    }()

    private let configuration: DogAPIRepositoryConfiguration

    init(configuration: DogAPIRepositoryConfiguration = .defaultConfiguration) {

        self.configuration = configuration
        super.init(baseURL: configuration.baseURLString)
    }

    func getBreeds(page: Int, pageSize: Int, order: DogBreedRepositorySortOption) async throws -> [Breed] {

        try await self.request(
            resource: .getBreeds(page: page, pageSize: pageSize, order: order),
            additionalHeaders: self.authorizationHeader
        )
    }
    
    func searchBreeds(query: String) async throws -> [Breed] {

        try await self.request(
            resource: .searchBreeds(query: query),
            additionalHeaders: self.authorizationHeader
        )
    }
}

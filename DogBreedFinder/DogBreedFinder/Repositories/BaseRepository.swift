//
//  BaseRepository.swift
//  DogBreedFinder
//
//  Created by António Lebres on 23/07/2025.
//

import Foundation

enum HTTPMethod: String {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkingError: Error {

    case invalidURL
    case invalidResponse
    case invalidData
    case encodingError
}

protocol BaseRequestResource {

    var path: String { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }
    var queryItems: [URLQueryItem] { get }
}

class BaseRepository<RequestResource: BaseRequestResource> {

    private let defaultHeaders: [String : String] = [
        "Content-Type" : "application/json"
    ]

    private let baseURL: String

    init(baseURL: String) {

        self.baseURL = baseURL
    }

    func request<T: Decodable>(resource: RequestResource,
                               session: URLSession = URLSession.shared,
                               additionalHeaders: [String : String] = [:]) async throws -> T {

        guard var url = URL(string: baseURL.appending(resource.path)) else {

            throw NetworkingError.invalidURL
        }

        if resource.queryItems.isEmpty == false {

            url = url.appending(queryItems: resource.queryItems)
        }

        var request = URLRequest(url: url)

        // Set method
        request.httpMethod = resource.method.rawValue

        // Set headers, overriding default if duplicated
        let allHeaders = self.defaultHeaders.merging(additionalHeaders) { (_, new) in new }

        allHeaders.forEach { header, value in

            request.setValue(value, forHTTPHeaderField: header)
        }

        // Set body
        if let body = resource.body {

            do {

                request.httpBody = try JSONEncoder().encode(body)

            } catch {

                throw NetworkingError.encodingError
            }
        }

        let (data, response) = try await session.data(for: request)

        guard let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {

            throw NetworkingError.invalidResponse
        }

        do {

            return try JSONDecoder().decode(T.self, from: data)

        } catch {

            throw NetworkingError.invalidData
        }
    }
}

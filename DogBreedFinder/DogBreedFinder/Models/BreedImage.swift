//
//  BreedImage.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import Foundation

struct BreedImage: Decodable, Hashable {

    enum CodingKeys: String, CodingKey {

        case id
        case width
        case height
        case urlString = "url"
    }

    let id: String?
    let width: Int?
    let height: Int?
    let urlString: String?
}

extension BreedImage {

    var url: URL? {

        guard let urlString = self.urlString,
              let url = URL(string: urlString) else {

            return nil
        }

        return url
    }
}

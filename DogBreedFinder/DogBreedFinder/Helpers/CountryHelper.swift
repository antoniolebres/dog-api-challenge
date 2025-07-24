//
//  CountryHelper.swift
//  DogBreedFinder
//
//  Created by António Lebres on 24/07/2025.
//

import Foundation

enum CountryHelper {

    static func countryName(for countryCode: String) -> String? {

        guard countryCode.isEmpty == false else {

            return nil
        }

        return Locale.current.localizedString(forRegionCode: countryCode)
    }
}

//
//  UIDevice+Helpers.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import UIKit

extension UIDevice {

    static var isPad: Bool {

        UIDevice.current.userInterfaceIdiom == .pad
    }
}

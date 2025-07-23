//
//  DogBreedFinderApp.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

import SwiftUI

@main
struct DogBreedFinderApp: App {

    private let dependencyManager = DogBreedFinderDependencyManager()

    var body: some Scene {

        WindowGroup {

            BaseView()
                .environmentObject(self.dependencyManager.router)
        }
    }
}

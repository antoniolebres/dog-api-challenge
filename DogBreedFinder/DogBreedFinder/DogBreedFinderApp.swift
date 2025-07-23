//
//  DogBreedFinderApp.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

import SwiftUI

@main
struct DogBreedFinderApp: App {

    @StateObject private var router = NavigationRouter()

    var body: some Scene {

        WindowGroup {

            BaseView()
                .environmentObject(self.router)
        }
    }
}

//
//  BaseView.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

import SwiftUI

struct BaseView: View {

    var body: some View {

        TabView {

            Tab("Breeds", systemImage: "dog") {

                NavigationStack {

                    BreedImagesView()
                }
            }

            Tab("Search", systemImage: "magnifyingglass") {

                NavigationStack {

                    BreedSearchView()
                }
            }
        }
    }
}

#Preview {
    BaseView()
}

//
//  DogBreedProgressView.swift
//  DogBreedFinder
//
//  Created by António Lebres on 25/07/2025.
//

import SwiftUI

struct DogBreedProgressView: View {

    var body: some View {

        ProgressView()
            .progressViewStyle(.circular)
            .controlSize(.extraLarge)
            .tint(.brown)
            .background(.clear)
    }
}

#Preview {
    DogBreedProgressView()
}

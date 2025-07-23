//
//  BackgroundModifier.swift
//  DogBreedFinder
//
//  Created by António Lebres on 23/07/2025.
//

import SwiftUI

struct BackgroundModifier: ViewModifier {

    func body(content: Content) -> some View {

        content
            .background(.brown.opacity(0.1))
    }
}

extension View {

    func dogBreedFinderBackground() -> some View {

        self.modifier(BackgroundModifier())
    }
}

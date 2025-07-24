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
            .background(Color(red: 0.92, green: 0.88, blue: 0.82))
    }
}

extension View {

    func dogBreedFinderBackground() -> some View {

        self.modifier(BackgroundModifier())
    }
}

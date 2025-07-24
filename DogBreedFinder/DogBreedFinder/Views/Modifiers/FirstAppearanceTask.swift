//
//  FirstAppearanceTask.swift
//  DogBreedFinder
//
//  Created by António Lebres on 24/07/2025.
//

import SwiftUI

struct FirstAppearanceTask: ViewModifier {

    let action: () async -> Void

    @State private var hasExecuted = false

    func body(content: Content) -> some View {

        content.task {

            guard self.hasExecuted == false else { return }
            self.hasExecuted = true

            await self.action()
        }
    }
}

extension View {

    func onFirstAppearTask(_ action: @escaping () async -> Void) -> some View {

        self.modifier(FirstAppearanceTask(action: action))
    }
}

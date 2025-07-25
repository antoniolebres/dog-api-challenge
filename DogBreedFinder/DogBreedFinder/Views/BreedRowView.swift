//
//  BreedRowView.swift
//  DogBreedFinder
//
//  Created by António Lebres on 24/07/2025.
//

import SwiftUI
import NukeUI

struct BreedRowView: View {

    let breed: Breed
    let textFont: Font

    init(
        breed: Breed,
        textFont: Font = .body
    ) {

        self.breed = breed
        self.textFont = textFont
    }

    var body: some View {

        HStack {

            LazyImage(url: self.breed.image?.url) { state in

                if let image = state.image {

                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            minWidth: Constants.minWidth,
                            maxWidth: Constants.maxWidth,
                            minHeight: Constants.minHeight,
                            maxHeight: Constants.maxHeight
                        )
                        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                        .transition(.opacity)

                } else {

                    ZStack {
                        Image(systemName: "dog.fill")
                            .foregroundStyle(.ultraThickMaterial)
                    }
                    .frame(
                        minWidth: Constants.minWidth,
                        maxWidth: Constants.maxWidth,
                        minHeight: Constants.minHeight,
                        maxHeight: Constants.maxHeight
                    )
                    .background(
                        .black.opacity(Constants.opacity),
                        in: RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    )
                }
            }

            Spacer()

            Text(self.breed.name)
                .font(self.textFont)
                .bold()

            Spacer()
        }
        .background(
            Constants.backgroundColor,
            in: RoundedRectangle(cornerRadius: Constants.cornerRadius)
        )
        .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius).stroke(.ultraThinMaterial, lineWidth: Constants.borderWidth))
    }
}

// MARK: - Private

private extension BreedRowView {

    enum Constants {

        static let backgroundColor: Color = .init(red: 0.9, green: 0.75, blue: 0.53)
        static let borderWidth: CGFloat = 2
        static let cornerRadius: CGFloat = 10

        static let minWidth: CGFloat = 75
        static let minHeight: CGFloat = 50
        static let maxWidth: CGFloat = 150
        static let maxHeight: CGFloat = 100
        static let opacity: CGFloat = 0.2
    }
}

#Preview {
    BreedRowView(breed: DummyData.breeds[0])
}

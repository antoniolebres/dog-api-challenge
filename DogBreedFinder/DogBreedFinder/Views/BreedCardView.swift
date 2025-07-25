//
//  BreedCardView.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import SwiftUI
import NukeUI

struct BreedCardView: View {

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

        ZStack(alignment: .bottom) {

            GeometryReader { geo in

                LazyImage(url: self.breed.image?.url) { state in

                    if let image = state.image {

                        image
                            .resizable()
                            .scaledToFill()
                            .transition(.opacity)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()

                    } else {

                        ZStack {
                            Image(systemName: "dog.fill")
                                .foregroundStyle(.ultraThickMaterial)
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                        .background(
                            .black.opacity(Constants.opacity),
                            in: RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        )
                    }
                }
            }

            HStack {

                Text(self.breed.name)
                    .font(self.textFont)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.ultraThickMaterial)
            }
            .padding(.vertical, Constants.verticalPadding)
            .background(.ultraThinMaterial)
        }
        .frame(
            minWidth: Constants.minWidth,
            maxWidth: Constants.maxWidth,
            minHeight: Constants.minHeight,
            maxHeight: Constants.maxHeight
        )
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        .shadow(radius: Constants.shadowRadius)
    }
}

// MARK: - Private

private extension BreedCardView {

    enum Constants {

        static let verticalPadding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let shadowRadius: CGFloat = 4
        static let opacity: CGFloat = 0.2

        static let minWidth: CGFloat = 175
        static let minHeight: CGFloat = 117
        static let maxWidth: CGFloat = 350
        static let maxHeight: CGFloat = 233
    }
}

#Preview {
    BreedCardView(breed: DummyData.breeds[0])
}

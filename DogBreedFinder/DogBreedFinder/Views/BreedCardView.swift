//
//  BreedCardView.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import SwiftUI

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

            // TODO: Replace by AsyncImage and use the real one

            Image(["test", "test2"].randomElement()!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 250)

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
    }
}

#Preview {
    BreedCardView(breed: DummyData.breeds[0])
}

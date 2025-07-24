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

            GeometryReader { geo in
                AsyncImage(url: self.breed.image?.url) { image in
                    
                    image
                        .resizable()
                        //.aspectRatio(contentMode: .fill)
                        .scaledToFill()
                        .transition(.opacity)
                        //.frame(minWidth: 175, maxWidth: 300, minHeight: 117, maxHeight: 200)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                    
                } placeholder: {

                    ZStack {
                        Image(systemName: "dog.fill")
                            .foregroundStyle(.ultraThickMaterial)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .background(
                        .black.opacity(0.2),
                        in: RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    )
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
        .frame(minWidth: 175, maxWidth: 350, minHeight: 117, maxHeight: 233)
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

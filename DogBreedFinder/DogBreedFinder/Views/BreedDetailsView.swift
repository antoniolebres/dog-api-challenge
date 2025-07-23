//
//  BreedDetailsView.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import SwiftUI

struct BreedDetailsView: View {

    @EnvironmentObject private var router: NavigationRouter

    @ObservedObject private var viewModel: BreedDetailsViewModel

    init(viewModel: BreedDetailsViewModel) {

        self.viewModel = viewModel
    }

    var body: some View {

        ScrollView {

            VStack {

                Image(["test", "test2"].randomElement()!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.ultraThinMaterial, lineWidth: 4))
                    .shadow(radius: 2)

                HStack {

                    Text(self.viewModel.breed.name)
                        .font(.title)
                        .bold()

                    Spacer()
                }
                .padding(.vertical)

                VStack(alignment: .leading, spacing: 16) {

                    if let group = self.viewModel.breed.breedGroup,
                       group.isEmpty == false {

                        self.dogRowView(
                            systemIconName: "rectangle.3.group",
                            title: "Group",
                            description: group
                        )
                    }

                    if let origin = self.viewModel.breedOrigin {

                        self.dogRowView(
                            systemIconName: "globe.desk",
                            title: "Origin",
                            description: origin
                        )
                    }

                    if let temperament = self.viewModel.breed.temperament,
                       temperament.isEmpty == false {

                        self.dogRowView(
                            systemIconName: "heart",
                            title: "Temperament",
                            description: temperament
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .bottom) {

            self.gotItButton
        }
        .background(.brown.opacity(0.1))
    }
}

// MARK: - Private

private extension BreedDetailsView {

    var gotItButton: some View {

        Button {

            self.router.navigateBack()

        } label: {

            Label("Paw-some!", systemImage: "pawprint.fill")
                .font(.title3)
                .bold()
                .foregroundStyle(.ultraThickMaterial)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .background(.brown, in: RoundedRectangle(cornerRadius: 10))
        .padding()
    }

    func dogRowView(systemIconName: String, title: String, description: String) -> some View {

        VStack(alignment: .leading) {

            HStack {

                Image(systemName: systemIconName)

                Text(title)
                    .bold()

                Spacer()
            }

            Text(description)
        }
        .padding()
        .background(.brown.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    BreedDetailsView(viewModel: .init(breed: DummyData.breeds[0]))
        .environmentObject(
            NavigationRouter(
                viewFactory: .init(dogBreedRepository: DummyRepository())
            )
        )
}

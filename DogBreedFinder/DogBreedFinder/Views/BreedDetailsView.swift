//
//  BreedDetailsView.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import SwiftUI
import NukeUI

struct BreedDetailsView: View {

    @EnvironmentObject private var router: NavigationRouter

    private var viewModel: BreedDetailsViewModel

    init(viewModel: BreedDetailsViewModel) {

        self.viewModel = viewModel
    }

    var body: some View {

        ScrollView {

            VStack {

                LazyImage(url: self.viewModel.breed.image?.url) { state in

                    if let image = state.image {

                        ZStack {

                            Group {

                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: Constants.height)
                                    .blur(radius: Constants.blurRadius)

                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity, maxHeight: Constants.height)
                            }
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(.ultraThinMaterial, lineWidth: Constants.strokeLineWidth)
                            )
                            .shadow(radius: Constants.shadowRadius)
                        }

                    } else {

                        ZStack {

                            Circle()
                                .fill(.brown)
                                .strokeBorder(.ultraThinMaterial, lineWidth: Constants.strokeLineWidth)

                            Image(systemName: "dog.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.ultraThickMaterial)
                        }
                        .frame(height: Constants.height)
                    }
                }

                HStack {

                    Text(self.viewModel.breed.name)
                        .font(.title)
                        .bold()

                    Spacer()
                }
                .padding(.vertical)

                VStack(alignment: .leading, spacing: Constants.stackSpacing) {

                    ForEach(self.viewModel.breedDetailSections, id: \.title) { section in

                        self.dogRowView(
                            systemIconName: section.systemIconName,
                            title: section.title,
                            description: section.description
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .bottom) {

            self.gotItButton
        }
        .dogBreedFinderBackground()
    }
}

// MARK: - Private

private extension BreedDetailsView {

    enum Constants {

        static let height: CGFloat = 300
        static let blurRadius: CGFloat = 5
        static let shadowRadius: CGFloat = 2
        static let strokeLineWidth: CGFloat = 4
        static let stackSpacing: CGFloat = 16
        static let cornerRadius: CGFloat = 10
        static let opacity: CGFloat = 0.2
    }

    var gotItButton: some View {

        Button {

            self.router.navigateBack()

        } label: {

            Label("Paw-some!", systemImage: "pawprint.fill")
                .font(.body)
                .bold()
                .foregroundStyle(.ultraThickMaterial)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .background(.brown, in: RoundedRectangle(cornerRadius: Constants.cornerRadius))
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
        .background(
            .brown.opacity(Constants.opacity),
            in: RoundedRectangle(cornerRadius: Constants.cornerRadius)
        )
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

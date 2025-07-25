//
//  BreedSearchView.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

import SwiftUI

struct BreedSearchView: View {

    @EnvironmentObject private var router: NavigationRouter

    @StateObject private var viewModel: BreedSearchViewModel

    init(viewModel: BreedSearchViewModel) {

        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {

        VStack {

            Group {

                switch self.viewModel.state {

                case .idle:
                    self.idleView

                case .loading:
                    DogBreedProgressView()

                case .loaded(let searchResults):
                    self.searchResultsList(results: searchResults)

                case .noResults:
                    self.noResultsView(searchTerm: self.viewModel.searchTerm)

                case .error:
                    ErrorView { self.viewModel.retry() }
                }

            }
            .searchable(
                text: self.$viewModel.searchTerm,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("Start typing to search...")
            )
        }
        .navigationTitle("Search")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .dogBreedFinderBackground()
    }
}

// MARK: - Private

private extension BreedSearchView {

    var idleView: some View {

        VStack(spacing: 16) {

            Image(systemName: "pawprint")
                .font(.largeTitle)
                .foregroundStyle(.brown)

            Text("Sniffing around for something?")
        }
    }

    func resultView(result: Breed) -> some View {

        VStack(alignment: .leading) {

            Text(result.name)
                .font(.headline)

            if let origin = result.origin,
               origin.isEmpty == false {

                Text(origin)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            if let temperament = result.temperament,
               temperament.isEmpty == false {

                Text(temperament)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    func searchResultsList(results: [Breed]) -> some View {

        List(results) { result in

            self.resultView(result: result)
                .onTapGesture {
                    self.router.navigate(to: .breedDetails(breed: result))
                }
        }
    }

    func noResultsView(searchTerm: String) -> some View {

        VStack(spacing: 16) {

            Image(systemName: "exclamationmark.magnifyingglass")
                .font(.largeTitle)
                .foregroundStyle(.brown)

            Text("Ooops! Not even a bone to fetch for '\(searchTerm)'")
                .font(.title2)
                .multilineTextAlignment(.center)

            Text("No results available, try changing your search")
                .foregroundStyle(.gray)
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        BreedSearchView(
            viewModel: .init(dogBreedRepository: DummyRepository())
        )
        .environmentObject(
            NavigationRouter(
                viewFactory: .init(dogBreedRepository: DummyRepository())
            )
        )
    }
}

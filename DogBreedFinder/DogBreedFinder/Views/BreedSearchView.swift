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
                placement: .navigationBarDrawer(displayMode: .automatic),
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

    enum Constants {

        static let stackSpacing: CGFloat = 16
        static let cornerRadius: CGFloat = 10
    }

    var idleView: some View {

        VStack(spacing: Constants.stackSpacing) {

            Image(systemName: "pawprint")
                .font(.largeTitle)
                .foregroundStyle(.brown)

            Text("Sniffing around for something?")
        }
    }

    func resultView(result: Breed) -> some View {

        HStack {

            VStack(alignment: .leading) {
                
                Text(result.name)
                    .font(.headline)
                
                if let origin = result.breedOrigin,
                   origin.isEmpty == false {
                    
                    Text(origin)
                        .font(.subheadline)
                }
                
                if let temperament = result.temperament,
                   temperament.isEmpty == false {
                    
                    Text(temperament)
                        .font(.caption)
                }
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.brown)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    }

    func searchResultsList(results: [Breed]) -> some View {

        List(results) { result in

            self.resultView(result: result)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .onTapGesture {
                    self.router.navigate(to: .breedDetails(breed: result))
                }
        }
        .listStyle(.plain)
        .background(.clear)
    }

    func noResultsView(searchTerm: String) -> some View {

        VStack(spacing: Constants.stackSpacing) {

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

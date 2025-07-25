//
//  BreedSearchViewModel.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

import Combine
import Foundation

enum BreedSearchViewModelState {

    case idle
    case loading
    case loaded(searchResults: [Breed])
    case noResults
    case error(Error)
}

class BreedSearchViewModel: ObservableObject {

    @Published var searchTerm: String = ""
    @Published var state: BreedSearchViewModelState = .idle

    private var cancellables = Set<AnyCancellable>()
    private let dogBreedRepository: DogBreedRepository

    init(dogBreedRepository: DogBreedRepository) {

        self.dogBreedRepository = dogBreedRepository
        self.bindSearch()
    }

    func bindSearch() {

        self.$searchTerm
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] searchText in

                self?.state = searchText.isEmpty ? .idle : .loading
            })
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { $0.isEmpty == false }
            .sink { [weak self] value in

                Task { [weak self] in

                    await self?.search(searchText: value)
                }
            }
            .store(in: &self.cancellables)
    }

    func retry() {

        let searchText = self.searchTerm.trimmingCharacters(in: .whitespaces)
        guard searchText.isEmpty == false else { return }

        Task { @MainActor in

            self.state = .loading
            await self.search(searchText: searchText)
        }
    }
}

// MARK: - Private

private extension BreedSearchViewModel {

    @MainActor
    func search(searchText: String) async {

        do {

            let searchResults = try await self.dogBreedRepository.searchBreeds(query: searchText)

            self.state = searchResults.isEmpty ? .noResults : .loaded(searchResults: searchResults)

        } catch {

            self.state = .error(error)
        }
    }
}

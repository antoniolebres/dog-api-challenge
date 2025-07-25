//
//  BreedImagesViewModel.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

import Foundation
import UIKit

enum BreedsPresentationType: String, CaseIterable {

    case grid = "Grid"
    case list = "List"

    var systemIconName: String {

        switch self {

        case .grid:
            "square.grid.2x2"

        case .list:
            "list.bullet"
        }
    }
}

enum BreedImagesViewModelState {

    case loading
    case loaded(breeds: [Breed], isLoadingNextPage: Bool)
    case error(Error)
}

enum SortOptions: String, CaseIterable {

    case ascending = "A → Z"
    case descending = "Z → A"

    var value: DogBreedRepositorySortOption {

        switch self {

        case .ascending:
            .ascending

        case .descending:
            .descending
        }
    }
}

class BreedImagesViewModel: ObservableObject {

    @Published var selectedViewPresentationType: BreedsPresentationType = UIDevice.isPad ? .grid : .list
    @Published var selectedOrder: SortOptions = .ascending {

        didSet {

            if self.selectedOrder != oldValue {

                Task { [weak self] in

                    await self?.getBreedsFirstPage()
                }
            }
        }
    }

    @Published var state: BreedImagesViewModelState = .loading

    private var currentPage: Int = 0
    private let pageSize: Int = 20

    private var canLoadMoreData = true
    private var isFetching = false

    private let dogBreedRepository: DogBreedRepository

    init(dogBreedRepository: DogBreedRepository) {

        self.dogBreedRepository = dogBreedRepository
    }
}

// MARK: - Data

extension BreedImagesViewModel {

    @MainActor
    func getBreedsFirstPage() async {

        self.state = .loading
        self.currentPage = 0

        await self.getBreeds(reset: true)
    }

    @MainActor
    func retry() async {

        await self.getBreedsFirstPage()
    }

    @MainActor
    func getBreedsNextPageIfNeeded(currentBreed: Breed?) async {

        guard let currentBreed,
              case .loaded(let breeds, let isLoadingNextPage) = self.state else { return }

        let isLastBreed = breeds.last == currentBreed

        guard isLastBreed,
              isLoadingNextPage == false,
              self.canLoadMoreData else { return }

        self.state = .loaded(breeds: breeds, isLoadingNextPage: true)

        await self.getBreeds(reset: false)
    }
}

// MARK: - Private

private extension BreedImagesViewModel {

    @MainActor
    func getBreeds(reset: Bool) async {

        guard self.isFetching == false else { return }

        self.isFetching = true

        defer { self.isFetching = false }

        do {

            let newBreeds = try await self.dogBreedRepository.getBreeds(
                page: self.currentPage,
                pageSize: self.pageSize,
                order: self.selectedOrder.value
            )

            if reset {

                self.state = .loaded(breeds: newBreeds, isLoadingNextPage: false)

            } else if case .loaded(let breeds, _) = self.state {

                let allBreeds = breeds + newBreeds
                self.state = .loaded(breeds: allBreeds, isLoadingNextPage: false)
            }

            self.canLoadMoreData = newBreeds.count == self.pageSize
            self.currentPage += 1

        } catch {

            self.state = .error(error)
        }
    }
}

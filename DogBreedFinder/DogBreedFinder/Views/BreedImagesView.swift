//
//  BreedImagesView.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

import SwiftUI

struct BreedImagesView: View {

    @EnvironmentObject private var router: NavigationRouter

    @StateObject private var viewModel: BreedImagesViewModel

    init(viewModel: BreedImagesViewModel) {

        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        
        VStack {

            switch self.viewModel.state {

            case .loading:
                DogBreedProgressView()

            case .loaded(let breeds, let isLoadingNextPage):
                switch self.viewModel.selectedViewPresentationType {

                case .grid:
                    self.gridView(
                        breeds: breeds,
                        isLoadingNextPage: isLoadingNextPage
                    )

                case .list:
                    self.listView(
                        breeds: breeds,
                        isLoadingNextPage: isLoadingNextPage
                    )
                }

            case .error:
                ErrorView {
                    Task {
                        await self.viewModel.retry()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Breeds")
        .dogBreedFinderBackground()
        .onFirstAppearTask {

            await self.viewModel.getBreedsFirstPage()
        }
        .toolbar {

            ToolbarItemGroup(placement: .topBarLeading) {

                self.viewPresentationTypePicker
            }

            ToolbarItemGroup(placement: .topBarTrailing) {

                self.sortMenu
            }
        }
    }
}

// MARK: - Private (List & Grid)

private extension BreedImagesView {

    enum Constants {

        static let columnLayout = [GridItem(.adaptive(minimum: 180))]
        static let gridSpacing: CGFloat = 16
    }

    func gridView(breeds: [Breed], isLoadingNextPage: Bool) -> some View {

        ScrollView {

            LazyVGrid(
                columns: Constants.columnLayout,
                alignment: .center,
                spacing: Constants.gridSpacing
            ) {

                ForEach(breeds) { breed in

                    BreedCardView(
                        breed: breed,
                        textFont: UIDevice.isPad ? .body : .caption
                    )
                    .onTapGesture {
                        self.router.navigate(to: .breedDetails(breed: breed))
                    }
                    .onAppear {
                        Task {
                            await self.viewModel.getBreedsNextPageIfNeeded(currentBreed: breed)
                        }
                    }
                }
            }
            .padding(.horizontal)

            if isLoadingNextPage {

                DogBreedProgressView()
            }
        }
    }

    func listView(breeds: [Breed], isLoadingNextPage: Bool) -> some View {

        List {

            Group {

                ForEach(breeds) { breed in

                    BreedRowView(
                        breed: breed,
                        textFont: UIDevice.isPad ? .body : .caption
                    )
                    .onTapGesture {
                        self.router.navigate(to: .breedDetails(breed: breed))
                    }
                    .onAppear {
                        Task {
                            await self.viewModel.getBreedsNextPageIfNeeded(currentBreed: breed)
                        }
                    }
                }

                if isLoadingNextPage {

                    DogBreedProgressView()
                        .id(UUID()) // to make sure it always appears
                        .frame(maxWidth: .infinity)
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .background(.clear)
    }
}

// MARK: - Private (Toolbar)

private extension BreedImagesView {

    var viewPresentationTypePicker: some View {

        Picker("View type", selection: self.$viewModel.selectedViewPresentationType) {

            ForEach(BreedsPresentationType.allCases, id: \.self) { type in

                Image(systemName: type.systemIconName)
                    .tag(type)
            }
        }
        .labelsHidden()
        .pickerStyle(.inline)
    }

    var sortMenu: some View {

        Picker("Sort Order", selection: self.$viewModel.selectedOrder) {

            ForEach(SortOptions.allCases, id: \.self) { order in

                Text(order.rawValue)
            }
        }
        .tint(.primary)
    }
}

#Preview {
    NavigationStack {
        BreedImagesView(
            viewModel: .init(dogBreedRepository: DummyRepository())
        )
        .environmentObject(
            NavigationRouter(
                viewFactory: .init(dogBreedRepository: DummyRepository())
            )
        )
    }
}

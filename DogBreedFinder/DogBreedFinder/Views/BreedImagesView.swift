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
                ProgressView()
                    .progressViewStyle(.circular)
                    .controlSize(.extraLarge)
                    .tint(.brown)
                    .background(.clear)

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

            ToolbarItemGroup(placement: .topBarTrailing) {

                self.viewPresentationTypePicker
            }
        }
    }
}

// MARK: - Private (List & Grid)

private extension BreedImagesView {

    enum Constants {

        static let columnLayout = [GridItem(.adaptive(minimum: 180))]
    }

    func gridView(breeds: [Breed], isLoadingNextPage: Bool) -> some View {

        ScrollView {

            LazyVGrid(
                columns: Constants.columnLayout,
                alignment: .center,
                spacing: 16
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

                ProgressView()
                    .progressViewStyle(.circular)
                    .controlSize(.extraLarge)
                    .tint(.brown)
                    .background(.clear)
            }
        }
    }

    func listView(breeds: [Breed], isLoadingNextPage: Bool) -> some View {

        List {

            ForEach(breeds) { breed in

                BreedRowView(
                    breed: breed,
                    textFont: UIDevice.isPad ? .body : .caption
                )
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
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

                ProgressView()
                    .id(UUID())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .controlSize(.extraLarge)
                    .frame(maxWidth: .infinity)
                    .tint(.brown)
                    .background(.clear)
            }
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

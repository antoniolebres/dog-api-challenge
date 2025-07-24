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

            switch self.viewModel.selectedPresentationType {

            case .grid:
                self.gridView

            case .list:
                self.listView
            }
        }
        .dogBreedFinderBackground()
        .navigationTitle("Breeds")
        .task {

            print("=== Task block")

            if self.viewModel.shouldRequestBreeds {

                print("=== Task block - triggered")
                await self.viewModel.getBreeds()
            }
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

        static let cardWidth: CGFloat = 200
        static let columnLayout = Array(
            repeating: GridItem(.fixed(Self.cardWidth)),
            count: UIDevice.isPad ? 3 : 2
        )
    }

    var gridView: some View {

        ScrollView {

            LazyVGrid(
                columns: Constants.columnLayout,
                alignment: .center,
                spacing: 16
            ) {

                ForEach(self.viewModel.breeds, id: \.id) { breed in

                    BreedCardView(
                        breed: breed,
                        textFont: UIDevice.isPad ? .body : .caption
                    )
                    .onTapGesture {
                        self.router.navigate(to: .breedDetails(breed: breed))
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    var listView: some View {

        List(self.viewModel.breeds) { breed in

            BreedCardView(breed: breed)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .onTapGesture {
                    self.router.navigate(to: .breedDetails(breed: breed))
                }
        }
        .listStyle(.plain)
        .background(.clear)
    }
}

// MARK: - Private (Toolbar)

private extension BreedImagesView {

    var viewPresentationTypePicker: some View {

        Picker("View type", selection: self.$viewModel.selectedPresentationType) {

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

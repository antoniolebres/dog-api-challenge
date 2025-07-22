//
//  BreedImagesView.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

import SwiftUI

struct BreedImagesView: View {

    @StateObject private var viewModel = BreedImagesViewModel()

    var body: some View {
        
        VStack {

            switch self.viewModel.selectedPresentationType {

            case .grid:
                self.gridView

            case .list:
                self.listView
            }
        }
        .navigationTitle("Breeds")
        .onAppear {

            self.viewModel.getBreeds()
        }
        .toolbar {

            ToolbarItemGroup(placement: .topBarTrailing) {

                self.viewPresentationTypePicker
                self.sortMenu
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
                }
            }
            .padding(.horizontal)
        }
    }

    var listView: some View {

        List(self.viewModel.breeds) { breed in

            BreedCardView(breed: breed)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

// MARK: - Private (Toolbar)

private extension BreedImagesView {

    var viewPresentationTypePicker: some View {

        Picker("View type", selection: self.$viewModel.selectedPresentationType) {

            ForEach(ViewPresentationType.allCases, id: \.self) { type in

                Image(systemName: type.systemIconName)
                    .tag(type)
            }
        }
        .labelsHidden()
        .pickerStyle(.inline)
    }

    var sortMenu: some View {

        Menu {

            Button {

                self.viewModel.didTapSortAlphabeticallyAscending()

            } label: {

                Label("Alphabetically (A-Z)", systemImage: "arrow.down")
            }

            Button {

                self.viewModel.didTapSortAlphabeticallyDescending()

            } label: {

                Label("Alphabetically (Z-A)", systemImage: "arrow.up")
            }

        } label: {

            Label("Sort", systemImage: "arrow.up.arrow.down")
        }
        .tint(.primary)
    }
}

#Preview {
    NavigationStack {
        BreedImagesView()
    }
}

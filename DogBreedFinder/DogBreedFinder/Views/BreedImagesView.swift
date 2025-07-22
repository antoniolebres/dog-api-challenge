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

            switch self.viewModel.pickerSelection {

            case .grid:
                self.gridView

            case .list:
                self.listView
            }
        }
        .onAppear {

            self.viewModel.getBreedImages()
        }
        .navigationTitle("Breeds")
        .toolbar {

            ToolbarItemGroup(placement: .topBarTrailing) {

                Picker("View type", selection: self.$viewModel.pickerSelection) {

                    ForEach(ViewPresentationType.allCases, id: \.self) { type in

                        Image(systemName: type.systemIconName)
                            .tag(type)
                    }
                }
                .labelsHidden()
                .pickerStyle(.inline)
            }
        }
    }
}

// MARK: - Private

private extension BreedImagesView {

    var gridView: some View {

        ScrollView {

            LazyVGrid(columns: Array(repeating: GridItem(), count: UIDevice.isPad ? 3 : 2)) {

                ForEach(self.viewModel.breeds, id: \.id) { breed in

                    BreedCardView(breed: breed, textFont: UIDevice.isPad ? .body : .caption)
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

#Preview {
    NavigationStack {
        BreedImagesView()
    }
}

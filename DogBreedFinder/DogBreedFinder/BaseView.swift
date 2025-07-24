//
//  BaseView.swift
//  DogBreedFinder
//
//  Created by António Lebres on 21/07/2025.
//

import SwiftUI

struct BaseView: View {

    @EnvironmentObject private var router: NavigationRouter

    var body: some View {

        TabView(selection: self.$router.currentTab) {

            ForEach(DogBreedFinderAppTab.allCases, id: \.rawValue) { tab in
                
                Tab(tab.rawValue, systemImage: tab.systemImageName, value: tab) {

                    NavigationStack(path: self.router.navigationStackPath(for: tab)) {

                        self.router.tabDestination(for: tab)
                            .navigationDestination(for: Route.self) {
                                self.router.navigationDestination(for: $0)
                            }
                    }
                    .tint(.brown)
                }
            }
        }
        .tint(.brown)
    }
}

#Preview {
    BaseView()
        .environmentObject(
            NavigationRouter(
                viewFactory: .init(dogBreedRepository: DummyRepository())
            )
        )
}

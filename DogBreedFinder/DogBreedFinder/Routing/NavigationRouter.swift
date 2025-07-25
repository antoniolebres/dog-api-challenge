//
//  NavigationRouter.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import SwiftUI

class NavigationRouter: ObservableObject {

    @Published var routes: [DogBreedFinderAppTab : [Route]] = [:]
    @Published var currentTab: DogBreedFinderAppTab = .breeds

    private let viewFactory: ViewFactory

    init(viewFactory: ViewFactory) {

        self.viewFactory = viewFactory
    }

    func navigate(to route: Route) {

        self.routes[self.currentTab, default: []].append(route)
    }

    func navigateBack() {

        guard self.routes[self.currentTab]?.isEmpty == false else {

            return
        }

        self.routes[self.currentTab]?.removeLast()
    }

    func navigateToRoot() {

        self.routes[self.currentTab]?.removeAll()
    }
}

// MARK: - Destination-related methods

extension NavigationRouter {

    func navigationDestination(for route: Route) -> some View {

        return self.viewFactory.buildView(for: route)
    }

    func tabDestination(for tab: DogBreedFinderAppTab) -> some View {

        return self.viewFactory.buildView(for: tab.baseRoute)
    }

    func navigationStackPath(for tab: DogBreedFinderAppTab) -> Binding<[Route]> {

        return Binding(
            get: { self.routes[tab, default: []] },
            set: { self.routes[tab] = $0 }
        )
    }
}

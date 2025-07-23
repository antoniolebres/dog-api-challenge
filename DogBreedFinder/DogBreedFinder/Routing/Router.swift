//
//  Router.swift
//  DogBreedFinder
//
//  Created by António Lebres on 22/07/2025.
//

import SwiftUI

class NavigationRouter: ObservableObject {

    @Published var routes = [Route]()

    func navigate(to route: Route) {

        self.routes.append(route)
    }

    func navigateBack() {

        guard self.routes.isEmpty == false else {
            return
        }

        self.routes.removeLast()
    }

    func reset() {

        self.routes.removeAll()
    }
}

//
//  DogBreedFinderDependencyManager.swift
//  DogBreedFinder
//
//  Created by António Lebres on 23/07/2025.
//

class DogBreedFinderDependencyManager {

    let dogBreedRepository: DogBreedRepository

    lazy var viewFactory: ViewFactory = {

        ViewFactory(dogBreedRepository: self.dogBreedRepository)
    }()

    lazy var router: NavigationRouter = {

        NavigationRouter(viewFactory: self.viewFactory)
    }()

    init() {

        // self.dogBreedRepository = DummyRepository()
        self.dogBreedRepository = DogAPIRepository()
    }
}

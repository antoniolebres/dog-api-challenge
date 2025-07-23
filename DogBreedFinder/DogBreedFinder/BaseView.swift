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

        TabView {

            ForEach(Tabs.allCases, id: \.rawValue) { tab in

                Tab(tab.rawValue, systemImage: tab.systemImageName) {

                    NavigationStack(path: self.$router.routes) {

                        tab.route.view
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
        .environmentObject(NavigationRouter())
}

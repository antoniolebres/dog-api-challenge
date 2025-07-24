//
//  ErrorView.swift
//  DogBreedFinder
//
//  Created by António Lebres on 24/07/2025.
//

import SwiftUI

struct ErrorView: View {

    let title: String
    let description: String?
    let retryAction: (() -> Void)?

    init(
        title: String = "Ooops... we got an error!",
        description: String? = nil,
        retryAction: (() -> Void)? = nil
    ) {

        self.title = title
        self.description = description
        self.retryAction = retryAction
    }

    var body: some View {
        
        VStack(spacing: 24) {

            Image(systemName: "exclamationmark.circle.fill")
                .foregroundStyle(.brown)
                .font(.system(size: 50))

            Text(self.title)
                .font(.title)

            if let description = self.description {

                Text(description)
                    .font(.title3)
            }

            if let action = self.retryAction {

                Button {

                    action()

                } label: {

                    Label("Retry", systemImage: "arrow.clockwise")
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.foreground)
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.brown, lineWidth: 2)
                )
            }
        }
    }
}

#Preview {
    ErrorView(
        description: "Please, try again") {
            print("Button tapped")
        }
}

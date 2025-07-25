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
        
        VStack(spacing: Constants.stackSpacing) {

            Image(systemName: "exclamationmark.circle.fill")
                .foregroundStyle(.brown)
                .font(.system(size: Constants.mainSystemIconFontSize))

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
                .padding(Constants.padding)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .stroke(.brown, lineWidth: Constants.strokeLineWidth)
                )
            }
        }
    }
}

// MARK: - Private

private extension ErrorView {

    enum Constants {

        static let padding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let strokeLineWidth: CGFloat = 2
        static let mainSystemIconFontSize: CGFloat = 50
        static let stackSpacing: CGFloat = 24
    }
}

#Preview {
    ErrorView(
        description: "Please, try again") {
            print("Button tapped")
        }
}

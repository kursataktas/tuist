//
//  QuickLaunchAppView.swift
//  Tophat
//
//  Created by Lukas Romsicki on 2022-12-12.
//  Copyright © 2022 Shopify. All rights reserved.
//

import SwiftUI

struct AppPreviewTile: View {
    var body: some View {
        VStack(spacing: 4) {
            AsyncImage(url: nil) { image in
                image
                    .pinnedApplicationImageStyle()
            } placeholder: {
                Image("AppIconPlaceholder")
                    .pinnedApplicationImageStyle()
            }

            Text("App")
                .font(.caption)
                .lineLimit(1)
                .truncationMode(.tail)

        }
    }
}

private extension Image {
    func pinnedApplicationImageStyle() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 44, height: 44)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)
    }
}

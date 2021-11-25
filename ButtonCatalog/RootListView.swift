//
//  RootListView.swift.swift
//  ButtonCatalog
//
//  Created by griffin-stewie on 2021/11/25.
//  
//

import SwiftUI

struct RootListView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    AnyUIViewControllerRepresentable(
                        make: { _ in ConfigurationTypesViewController() },
                        update: { _, _ in }
                    )
                } label: {
                    Text("Configuration Types")
                }

                NavigationLink {
                    AnyUIViewControllerRepresentable(
                        make: { _ in ButtonSizesViewController() },
                        update: { _, _ in }
                    )
                } label: {
                    Text("Button Sizes")
                }

                NavigationLink {
                    AnyUIViewControllerRepresentable(
                        make: { _ in ImagePositionsViewController() },
                        update: { _, _ in }
                    )
                } label: {
                    Text("Image Placement")
                }

                NavigationLink {
                    AnyUIViewControllerRepresentable(
                        make: { _ in TitleAlignmentsViewController() },
                        update: { _, _ in }
                    )
                } label: {
                    Text("Subtitle and TextAlignment")
                }
            }
        }
        .navigationTitle("Button Catalog")
    }
}

struct RootListView_swift_Previews: PreviewProvider {
    static var previews: some View {
        RootListView()
    }
}

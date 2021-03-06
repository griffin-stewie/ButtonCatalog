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
                Group {
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

                    NavigationLink {
                        AnyUIViewControllerRepresentable(
                            make: { _ in MultilineViewController() },
                            update: { _, _ in }
                        )
                    } label: {
                        Text("Multiline Title")
                    }

                    NavigationLink {
                        AnyUIViewControllerRepresentable(
                            make: { _ in SimpleCustomBackgroundViewController() },
                            update: { _, _ in }
                        )
                    } label: {
                        Text("Background Customization")
                    }

                    NavigationLink {
                        AnyUIViewControllerRepresentable(
                            make: { _ in UpdateButtonTextViewController() },
                            update: { _, _ in }
                        )
                    } label: {
                        Text("Update Button Title")
                    }

                    NavigationLink {
                        AnyUIViewControllerRepresentable(
                            make: { _ in ActivityIndicatorInsideButtonViewController() },
                            update: { _, _ in }
                        )
                    } label: {
                        Text("Show ActivityIndicator inside button")
                    }
                }

                Group {
                    NavigationLink {
                        AnyUIViewControllerRepresentable(
                            make: { _ in ToggleViewController() },
                            update: { _, _ in }
                        )
                    } label: {
                        Text("Toggle button")
                    }

                    NavigationLink {
                        AnyUIViewControllerRepresentable(
                            make: { _ in PopupButtonViewController() },
                            update: { _, _ in }
                        )
                    } label: {
                        Text("Pop-up button")
                    }

                    NavigationLink {
                        AnyUIViewControllerRepresentable(
                            make: { _ in PulldownButtonViewController() },
                            update: { _, _ in }
                        )
                    } label: {
                        Text("Pull-down button")
                    }

                    NavigationLink {
                        AnyUIViewControllerRepresentable(
                            make: { _ in DeferredPulldownButtonViewController() },
                            update: { _, _ in }
                        )
                    } label: {
                        Text("Deferred Pull-down button")
                    }
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

// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Splash",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(
      name: "Splash",
      targets: ["Splash"]
    )
  ],
  dependencies: [
    .package(path: "../Core/AppCore"),
    .package(path: "../Shared/DesignSystem"),
    .package(path: "../Shared/Localization")
  ],
  targets: [
    .target(
      name: "Splash",
      dependencies: [
        .product(name: "AppCore", package: "AppCore"),
        .product(name: "DesignSystem", package: "DesignSystem"),
        .product(name: "Localization", package: "Localization")
      ]
    ),
    .testTarget(
      name: "SplashTests",
      dependencies: ["Splash"]
    )
  ]
)

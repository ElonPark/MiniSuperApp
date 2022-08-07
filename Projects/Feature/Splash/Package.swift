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
    .package(url: "https://github.com/uber/RIBs.git", branch: "main"),
    .package(url: "https://github.com/uber/needle.git", .upToNextMajor(from: "0.18.1")),
    .package(path: "../Core/AppCore"),
    .package(path: "../Shared/DesignSystem"),
    .package(path: "../Shared/Localization")
  ],
  targets: [
    .target(
      name: "SplashInterface",
      dependencies: [
        "RIBs",
        .product(name: "NeedleFoundation", package: "needle")
      ]
    ),
    .target(
      name: "Splash",
      dependencies: [
        "SplashInterface",
        "AppCore",
        "DesignSystem",
        "Localization"
      ],
      cSettings: [
        .define("FLEXLAYOUT_SWIFT_PACKAGE")
      ]
    ),
    .testTarget(
      name: "SplashTests",
      dependencies: ["Splash"]
    )
  ]
)

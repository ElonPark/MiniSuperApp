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
    ),
    .library(
      name: "SplashInterface",
      targets: ["SplashInterface"]
    ),
    .library(
      name: "SplashTestSupport",
      targets: ["SplashTestSupport"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/uber/RIBs.git", branch: "main"),
    .package(url: "https://github.com/uber/needle.git", .upToNextMajor(from: "0.18.1")),
    .package(path: "../Core"),
    .package(path: "../Shared")
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
      name: "SplashTestSupport",
      dependencies: [
        "RIBs",
        "SplashInterface",
        .product(name: "AppTestSupport", package: "Core")
      ]
    ),
    .target(
      name: "Splash",
      dependencies: [
        "SplashInterface",
        .product(name: "AppFoundation", package: "Core"),
        .product(name: "Platform", package: "Core"),
        .product(name: "Network", package: "Core"),
        .product(name: "DesignSystem", package: "Shared"),
        .product(name: "Localization", package: "Shared")
      ],
      cSettings: [
        .define("FLEXLAYOUT_SWIFT_PACKAGE")
      ]
    ),
    .testTarget(
      name: "SplashTests",
      dependencies: [
        "Splash",
        .product(name: "AppTestSupport", package: "Core")
      ],
      cSettings: [
        .define("FLEXLAYOUT_SWIFT_PACKAGE")
      ]
    )
  ]
)

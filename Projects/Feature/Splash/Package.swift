// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Splash",
  platforms: [
    .iOS(.v14),
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
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.5.0"),
    .package(url: "https://github.com/uber/RIBs.git", branch: "main"),
    .package(url: "https://github.com/uber/needle.git", .upToNextMajor(from: "0.18.1")),
    .package(path: "../../Shared"),
    .package(path: "../../Core"),
    .package(path: "../../Data/BootstrapData"),
  ],
  targets: [
    .target(
      name: "SplashInterface",
      dependencies: [
        .product(name: "RIBs", package: "RIBs"),
        .product(name: "RxSwift", package: "RxSwift"),
        .product(name: "NeedleFoundation", package: "needle"),
      ]
    ),
    .target(
      name: "SplashTestSupport",
      dependencies: [
        "SplashInterface",
        .product(name: "RIBs", package: "RIBs"),
        .product(name: "AppTestSupport", package: "Shared"),
      ]
    ),
    .target(
      name: "Splash",
      dependencies: [
        "SplashInterface",
        .product(name: "AppFoundation", package: "Shared"),
        .product(name: "Platform", package: "Shared"),
        .product(name: "DesignSystem", package: "Shared"),
        .product(name: "Localization", package: "Shared"),
        .product(name: "NetworkInterface", package: "Core"),
        .product(name: "BootstrapDomain", package: "BootstrapData"),
      ],
      cSettings: [
        .define("FLEXLAYOUT_SWIFT_PACKAGE"),
      ]
    ),
    .testTarget(
      name: "SplashTests",
      dependencies: [
        "Splash",
        .product(name: "AppTestSupport", package: "Shared"),
      ],
      cSettings: [
        .define("FLEXLAYOUT_SWIFT_PACKAGE"),
      ]
    ),
  ]
)

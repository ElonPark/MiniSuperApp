// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LoggedOut",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(
      name: "LoggedOut",
      targets: ["LoggedOut"]
    ),
    .library(
      name: "LoggedOutInterface",
      targets: ["LoggedOutInterface"]
    ),
    .library(
      name: "LoggedOutTestSupport",
      targets: ["LoggedOutTestSupport"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/uber/RIBs.git", branch: "main"),
    .package(url: "https://github.com/uber/needle.git", .upToNextMajor(from: "0.18.1")),
    .package(path: "../../Core"),
    .package(path: "../../Shared")
  ],
  targets: [
    .target(
      name: "LoggedOutInterface",
      dependencies: [
        .product(name: "RIBs", package: "RIBs"),
        .product(name: "NeedleFoundation", package: "needle")
      ]
    ),
    .target(
      name: "LoggedOutTestSupport",
      dependencies: [
        "LoggedOutInterface",
        .product(name: "RIBs", package: "RIBs"),
        .product(name: "AppTestSupport", package: "Shared")
      ]
    ),
    .target(
      name: "LoggedOut",
      dependencies: [
        .product(name: "AppFoundation", package: "Shared"),
        .product(name: "Platform", package: "Shared"),
        .product(name: "DesignSystem", package: "Shared"),
        .product(name: "Localization", package: "Shared"),
        .product(name: "NetworkInterface", package: "Core")
      ],
      cSettings: [
        .define("FLEXLAYOUT_SWIFT_PACKAGE")
      ]
    ),
    .testTarget(
      name: "LoggedOutTests",
      dependencies: [
        "LoggedOut",
        .product(name: "AppTestSupport", package: "Shared")
      ],
      cSettings: [
        .define("FLEXLAYOUT_SWIFT_PACKAGE")
      ]
    )
  ]
)

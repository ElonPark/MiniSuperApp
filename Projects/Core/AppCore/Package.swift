// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppCore",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(
      name: "AppCore",
      targets: ["AppCore"]
    )
  ],
  dependencies: [
    .package(path: "../AppFoundation"),
    .package(path: "../Platform"),
    .package(path: "../Network"),
    .package(path: "../Entity")
  ],
  targets: [
    .target(
      name: "AppCore",
      dependencies: [
        .product(name: "AppFoundation", package: "AppFoundation"),
        .product(name: "Platform", package: "Platform"),
        .product(name: "Network", package: "Network"),
        .product(name: "Entity", package: "Entity")
      ]
    ),
    .testTarget(
      name: "AppCoreTests",
      dependencies: ["AppCore"]
    )
  ]
)

// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Localization",
  defaultLocalization: "ko",
  products: [
    .library(
      name: "Localization",
      targets: ["Localization"]
    )
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Localization",
      dependencies: [],
      resources: [
        .process("Resources")
      ]
    ),
    .testTarget(
      name: "LocalizationTests",
      dependencies: ["Localization"]
    )
  ]
)

// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Shared",
  defaultLocalization: "en",
  platforms: [.iOS(.v14)],
  products: [
    .library(
      name: "AppResource",
      targets: ["AppResource"]
    ),
    .library(
      name: "DesignSystem",
      targets: ["DesignSystem"]
    ),
    .library(
      name: "Localization",
      targets: ["Localization"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/layoutBox/FlexLayout.git", .upToNextMajor(from: "1.3.24")),
    .package(url: "https://github.com/layoutBox/PinLayout.git", .upToNextMajor(from: "1.10.3")),
    .package(url: "https://github.com/devxoul/Then", .upToNextMajor(from: "3.0.0"))
  ],
  targets: [
    .target(
      name: "AppResource",
      dependencies: [],
      resources: [
        .process("Resources")
      ]
    ),
    .target(
      name: "DesignSystem",
      dependencies: [
        "FlexLayout",
        "PinLayout",
        "Then",
        "AppResource"
      ]
    ),
    .target(
      name: "Localization",
      dependencies: [],
      resources: [
        .process("Resources")
      ]
    )
  ]
)

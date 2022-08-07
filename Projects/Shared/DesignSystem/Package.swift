// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "DesignSystem",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(
      name: "DesignSystem",
      targets: ["DesignSystem"]
    )
  ],
  dependencies: [
    .package(path: "../AppResource"),
    .package(url: "https://github.com/layoutBox/FlexLayout.git", .upToNextMajor(from: "1.3.24")),
    .package(url: "https://github.com/layoutBox/PinLayout.git", .upToNextMajor(from: "1.10.3")),
    .package(url: "https://github.com/devxoul/Then", .upToNextMajor(from: "3.0.0"))
  ],
  targets: [
    .target(
      name: "DesignSystem",
      dependencies: [
        "FlexLayout",
        "PinLayout",
        "Then",
        "AppResource"
      ]
    ),
    .testTarget(
      name: "DesignSystemTests",
      dependencies: ["DesignSystem"]
    )
  ]
)

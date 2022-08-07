// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppResource",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(
      name: "AppResource",
      targets: ["AppResource"]
    )
  ],
  dependencies: [],
  targets: [
    .target(
      name: "AppResource",
      dependencies: [],
      resources: [
        .process("Resources")
      ]
    ),
    .testTarget(
      name: "AppResourceTests",
      dependencies: ["AppResource"]
    )
  ]
)

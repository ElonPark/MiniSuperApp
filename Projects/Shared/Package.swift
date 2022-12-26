// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Shared",
  defaultLocalization: "en",
  platforms: [.iOS(.v14)],
  products: [
    .plugin(
      name: "MockGenerator",
      targets: ["MockGenerator"]
    ),
    .library(
      name: "AppFoundation",
      targets: ["AppFoundation"]
    ),
    .library(
      name: "AppTestSupport",
      targets: ["AppTestSupport"]
    ),
    .library(
      name: "Platform",
      targets: ["Platform"]
    ),
    .library(
      name: "Entity",
      targets: ["Entity"]
    ),
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
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.5.0"),
    .package(url: "https://github.com/uber/RIBs.git", branch: "main"),
    .package(url: "https://github.com/layoutBox/FlexLayout.git", .upToNextMajor(from: "1.3.24")),
    .package(url: "https://github.com/layoutBox/PinLayout.git", .upToNextMajor(from: "1.10.3")),
    .package(url: "https://github.com/devxoul/Then", .upToNextMajor(from: "3.0.0")),
  ],
  targets: [
    .plugin(
      name: "MockGenerator",
      capability: .command(
        intent: .custom(
          verb: "mockolo",
          description: "Generate mock files from Swift protocols"
        ),
        permissions: [
          .writeToPackageDirectory(reason: "Generate mock files info package"),
        ]
      )
    ),
    .target(
      name: "AppFoundation",
      dependencies: ["RIBs"]
    ),
    .target(
      name: "AppTestSupport",
      dependencies: ["RIBs"]
    ),
    .target(
      name: "Platform",
      dependencies: [
        .product(name: "RxSwift", package: "RxSwift"),
        .product(name: "RxRelay", package: "RxSwift"),
        "Entity",
      ]
    ),
    .target(
      name: "Entity",
      dependencies: []
    ),
    .target(
      name: "AppResource",
      dependencies: [],
      resources: [
        .process("Resources"),
      ]
    ),
    .target(
      name: "DesignSystem",
      dependencies: [
        "FlexLayout",
        "PinLayout",
        "Then",
        "AppResource",
      ],
      cSettings: [
        .define("FLEXLAYOUT_SWIFT_PACKAGE"),
      ],
      cxxSettings: [
        .define("FLEXLAYOUT_SWIFT_PACKAGE"),
      ],
      swiftSettings: [
        .define("FLEXLAYOUT_SWIFT_PACKAGE"),
      ]
    ),
    .target(
      name: "Localization",
      dependencies: [],
      resources: [
        .process("Resources"),
      ]
    ),
    .testTarget(
      name: "PlatformTests",
      dependencies: [
        "Platform",
        "AppTestSupport",
      ]
    ),
  ]
)

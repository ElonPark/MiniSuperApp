// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Core",
  platforms: [.iOS(.v14)],
  products: [
    .library(
      name: "Network",
      targets: ["Network"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.5.0"),
    .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0"))
  ],
  targets: [
    .target(
      name: "Network",
      dependencies: [
        .product(name: "RxMoya", package: "Moya")
      ]
    ),
    .testTarget(
      name: "NetworkTests",
      dependencies: ["Network"]
    )
  ]
)

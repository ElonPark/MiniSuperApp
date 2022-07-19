// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Platform",
  products: [
    .library(
      name: "Platform",
      targets: ["Platform"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.5.0"),
    .package(path: "../Entity")
  ],
  targets: [
    .target(
      name: "Platform",
      dependencies: [
        .product(name: "RxSwift", package: "RxSwift"),
        .product(name: "RxRelay", package: "RxSwift"),
        .product(name: "Entity", package: "Entity")
      ]
    ),
    .testTarget(
      name: "PlatformTests",
      dependencies: ["Platform"]
    )
  ]
)

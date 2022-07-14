import ProjectDescription

let dependencies = Dependencies(
  swiftPackageManager: [
    .remote(url: "https://github.com/uber/RIBs.git", requirement: .branch("main")),
    .remote(url: "https://github.com/uber/needle.git", requirement: .upToNextMajor(from: "0.18.1")),
    .remote(url: "https://github.com/layoutBox/FlexLayout.git", requirement: .upToNextMajor(from: "1.3.24")),
    .remote(url: "https://github.com/layoutBox/PinLayout.git", requirement: .upToNextMajor(from: "1.10.3")),
    .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "3.0.0")),
    .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMajor(from: "6.5.0"))

  ],
  platforms: [.iOS]
)

import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(
  name: "SplashSample",
  platform: .iOS,
  scripts: [
    Project.needleGenerateScript()
  ],
  additionalTargetDependency: [
    LocalDependencies.Feature.splash.package,
    RemoteDependencies.needleFoundation.package
  ],
  additionalPackages: [
    LocalDependencies.Feature.splash.packageSourceForSample,
    RemoteDependencies.needleFoundation.packageSource
  ]
)

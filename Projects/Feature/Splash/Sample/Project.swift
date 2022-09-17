import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(
  name: "SplashSample",
  platform: .iOS,
  scripts: [
    Project.needleGenerateScriptForFeature()
  ],
  additionalTargetDependency: [
    LocalDependencies.Feature.splash.package,
    LocalDependencies.Core.network.package,
    RemoteDependencies.needleFoundation.package
  ],
  additionalPackages: [
    LocalDependencies.Feature.splash.packageSource,
    LocalDependencies.Core.network.packageSource,
    RemoteDependencies.needleFoundation.packageSource
  ]
)

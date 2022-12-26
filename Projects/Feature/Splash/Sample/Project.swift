import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(
  name: "SplashSample",
  platform: .iOS,
  scripts: [
    Project.needleGenerateScriptForFeature(),
  ],
  additionalTargetDependency: [
    RemoteDependencies.needleFoundation.package,
    CoreDependencies.network.package,
    FeatureDependencies.splash.package,
  ],
  additionalPackages: [
    RemoteDependencies.needleFoundation.packageSource,
    CoreDependencies.network.packageSource,
    FeatureDependencies.splash.packageSource,
  ]
)

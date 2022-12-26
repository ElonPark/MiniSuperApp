import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(
  name: "LoggedOutSample",
  platform: .iOS,
  scripts: [
    Project.needleGenerateScriptForFeature(),
  ],
  additionalTargetDependency: [
    RemoteDependencies.needleFoundation.package,
    CoreDependencies.network.package,
    FeatureDependencies.loggedOut.package,
  ],
  additionalPackages: [
    RemoteDependencies.needleFoundation.packageSource,
    CoreDependencies.network.packageSource,
    FeatureDependencies.loggedOut.packageSource,
  ]
)

import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {

  public static func defaultSettings() -> Settings {
    .settings(
      base: [:],
      configurations: [
        .debug(name: .debug),
        .release(name: .release)
      ],
      defaultSettings: .recommended
    )
  }

  /// Helper function to create the Project for this ExampleApp
  public static func app(
    name: String,
    platform: Platform,
    additionalTargets: [String]
  ) -> Project {
    var targets = self.makeAppTargets(
      name: name,
      platform: platform,
      dependencies: additionalTargets.map { TargetDependency.target(name: $0) }
    )
    targets += additionalTargets.flatMap {
      self.makeFrameworkTargets(name: $0, platform: platform)
    }

    return Project(
      name: name,
      organizationName: "com.elonpark",
      targets: targets
    )
  }

  // MARK: - Private

  /// Helper function to create a framework target and an associated unit test target
  private static func makeFrameworkTargets(name: String, platform: Platform) -> [Target] {
    let sources = Target(
      name: name,
      platform: platform,
      product: .framework,
      bundleId: "com.elonpark.\(name)",
      infoPlist: .default,
      sources: ["Projects/Feature/\(name)/Sources/**"],
      resources: [],
      dependencies: []
    )
    let tests = Target(
      name: "\(name)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "com.elonpark.\(name)Tests",
      infoPlist: .default,
      sources: ["Projects/Feature/\(name)/Tests/**"],
      resources: [],
      dependencies: [.target(name: name)]
    )
    return [sources, tests]
  }

  /// Helper function to create the application target and the unit test target.
  private static func makeAppTargets(
    name: String,
    platform: Platform,
    dependencies: [TargetDependency]
  ) -> [Target] {
    let platform: Platform = platform
    let infoPlist: [String: InfoPlist.Value] = [
      "CFBundleShortVersionString": "1.0",
      "CFBundleVersion": "1",
      "UIMainStoryboardFile": "",
      "UILaunchStoryboardName": "LaunchScreen"
    ]

    let mainTarget = Target(
      name: name,
      platform: platform,
      product: .app,
      bundleId: "com.elonpark.\(name)",
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["Projects/Feature/\(name)/Sources/**"],
      resources: ["Projects/Feature/\(name)/Resources/**"],
      dependencies: dependencies
    )

    let testTarget = Target(
      name: "\(name)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "com.elonpark.\(name)Tests",
      infoPlist: .default,
      sources: ["Targets/\(name)/Tests/**"],
      dependencies: [
        .target(name: "\(name)")
      ]
    )
    return [mainTarget, testTarget]
  }
}

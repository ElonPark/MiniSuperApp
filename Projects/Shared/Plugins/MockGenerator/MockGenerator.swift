import Foundation
import PackagePlugin

@main
struct MockGenerator: CommandPlugin {

  func performCommand(context: PluginContext, arguments: [String]) async throws {
    let factory = MockoloArgumentsFactory()

    for target in context.package.targets {
      guard !target.name.contains("Test") else { continue }
      guard let target = target as? SourceModuleTarget else { continue }

      let projectsPath = "\(target.directory.string)/../../../.."
      let destination: String
      let arguments: [String]

      switch self.targetType(target.name) {
      case .feature:
        (destination, arguments) = factory.makeFeatureArguments(
          target: target,
          projectsPath: projectsPath
        )
      case .featureInterface:
        (destination, arguments) = factory.makeFeatureInterfaceArguments(
          target: target,
          projectsPath: projectsPath
        )
      case .domain:
        (destination, arguments) = factory.makeDomainArguments(
          target: target,
          projectsPath: projectsPath
        )
      case .data:
        (destination, arguments) = factory.makeDataArguments(
          target: target,
          projectsPath: projectsPath
        )
      }

      try self.executeMockolo(withArguments: arguments)
      try self.executeSwiftFormat(forFile: destination)
    }
  }

  private func targetType(_ targetName: String) -> SourceModuleTargetType {
    if targetName.hasSuffix("Interface") {
      return .featureInterface
    } else if targetName.hasSuffix("Domain") {
      return .domain
    } else if targetName.hasSuffix("Data") {
      return .data
    } else {
      return .feature
    }
  }

  private func executeMockolo(withArguments arguments: [String]) throws {
    let url = URL(fileURLWithPath: "/opt/homebrew/bin/mockolo")
    try self.executeProcess(name: "Mockolo", url: url, arguments: arguments)
  }

  private func executeSwiftFormat(forFile file: String) throws {
    let url = URL(fileURLWithPath: "/opt/homebrew/bin/swiftformat")
    try self.executeProcess(name: "SwiftFormat", url: url, arguments: [file])
  }

  private func executeProcess(name: String, url: URL, arguments: [String]? = nil) throws {
    let task = Process()
    task.executableURL = url
    task.arguments = arguments

    try task.run()
    task.waitUntilExit()

    guard task.terminationReason == .exit && task.terminationStatus == 0 else {
      let problem = "\(task.terminationReason): \(task.terminationStatus)"
      Diagnostics.error("\(name) invocation failed: \(problem)")
      return
    }

    print("\(name) generate finish")
  }
}

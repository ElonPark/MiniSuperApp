import Foundation
import PackagePlugin

@main
struct FeatureMockGenerator: CommandPlugin {
  func performCommand(context: PluginContext, arguments: [String]) async throws {
    for target in context.package.targets {
      guard !target.name.contains("Test") else { continue }
      guard let target = target as? SourceModuleTarget else { continue }

      let projectsPath = "\(target.directory.string)/../../../.."
      let mockfile: String
      let arguments: [String]

      if self.isInterface(target.name) {
        let feature = String(target.name.dropLast("Interface".count))
        mockfile = "\(projectsPath)/Feature/\(feature)/Sources/\(feature)TestSupport/\(target.name)Mocks.swift"
        arguments = [
          "-s", target.directory.string,
          "-d", mockfile,
          "-x", "Tests", "Resources", "Resource", "Localization",
          "--mockfiles", "\(projectsPath)/Shared/Sources/AppTestSupport/RIBsMocks.swift",
          "--use-mock-observable",
          "--mock-final",
          "--custom-imports", "AppTestSupport", target.name,
          "--exclude-imports",
          "NeedleFoundation",
          "AppFoundation",
          "AppResource",
          "DesignSystem",
          "Localization",
          "Network",
          "UIKit"
        ]
      } else {
        mockfile = "\(projectsPath)/Feature/\(target.name)/Tests/\(target.name)Tests/\(target.name)Mocks.swift"
        arguments = [
          "-s", "\(target.directory.string)/../",
          "-d", "\(projectsPath)/Feature/\(target.name)/Tests/\(target.name)Tests/\(target.name)Mocks.swift",
          "-i", target.name,
          "-x", "Tests", "Resources", "Resource", "Localization",
          "--mockfiles", "\(projectsPath)/Shared/Sources/AppTestSupport/RIBsMocks.swift",
          "--use-mock-observable",
          "--mock-final",
          "--custom-imports", "AppTestSupport",
          "--exclude-imports",
          "NeedleFoundation",
          "AppFoundation",
          "AppResource",
          "DesignSystem",
          "Localization",
          "Network",
          "UIKit"
        ]
      }

      try self.mockolo(with: arguments)
      try self.swiftFormat(to: mockfile)
    }
  }

  private func isInterface(_ targetName: String) -> Bool {
    return targetName.hasSuffix("Interface")
  }

  private func mockolo(with arguments: [String]) throws {
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/opt/homebrew/bin/mockolo")
    task.arguments = arguments

    try task.run()
    task.waitUntilExit()

    if task.terminationReason == .exit, task.terminationStatus == 0 {
      print("Mockolo generate finish")
    } else {
      let problem = "\(task.terminationReason): \(task.terminationStatus)"
      Diagnostics.error("Mockolo invocation failed: \(problem)")
    }
  }

  private func swiftFormat(to file: String) throws {
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/opt/homebrew/bin/swiftformat")
    task.arguments = [file]

    try task.run()
    task.waitUntilExit()

    if task.terminationReason == .exit, task.terminationStatus == 0 {
      print("SwiftFormat finish")
    } else {
      let problem = "\(task.terminationReason): \(task.terminationStatus)"
      Diagnostics.error("SwiftFormat invocation failed: \(problem)")
    }
  }
}

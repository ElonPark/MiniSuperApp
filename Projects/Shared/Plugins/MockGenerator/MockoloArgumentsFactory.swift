//
//  File.swift
//
//
//  Created by Elon on 2022/10/10.
//

import Foundation
import PackagePlugin

struct MockoloArgumentsFactory {

  func makeFeatureArguments(
    target: SourceModuleTarget,
    projectsPath: String
  ) -> (destination: String, arguments: [String]) {
    let destination = self.destination(
      for: .feature,
      projectsPath: projectsPath,
      withName: target.name
    )

    let arguments = [
      "-s", "\(target.directory.string)/../",
      "-d", destination,
      "-i", target.name,
      "-x", "Tests", "Resources", "Resource", "Localization",
      "--mockfiles", self.ribsMocks(projectsPath),
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

    return (destination, arguments)
  }

  func makeFeatureInterfaceArguments(
    target: SourceModuleTarget,
    projectsPath: String
  ) -> (destination: String, arguments: [String]) {
    let destination = self.destination(
      for: .featureInterface,
      projectsPath: projectsPath,
      withName: target.name
    )

    let arguments = [
      "-s", target.directory.string,
      "-d", destination,
      "-x", "Tests", "Resources", "Resource", "Localization",
      "--mockfiles", self.ribsMocks(projectsPath),
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

    return (destination, arguments)
  }

  private func ribsMocks(_ projectsPath: String) -> String {
    return "\(projectsPath)/Shared/Sources/AppTestSupport/RIBsMocks.swift"
  }

  func makeDomainArguments(
    target: SourceModuleTarget,
    projectsPath: String
  ) -> (destination: String, arguments: [String]) {
    let destination = self.destination(
      for: .domain,
      projectsPath: projectsPath,
      withName: target.name
    )

    let arguments = [
      "-s", target.directory.string,
      "-d", destination,
      "--use-mock-observable",
      "--mock-final",
      "--custom-imports", target.name,
      "--exclude-imports",
      "NeedleFoundation",
      "AppFoundation",
      "AppResource",
      "DesignSystem",
      "Localization",
      "Network",
      "UIKit"
    ]

    return (destination, arguments)
  }

  func makeDataArguments(
    target: SourceModuleTarget,
    projectsPath: String
  ) -> (destination: String, arguments: [String]) {
    let destination = self.destination(
      for: .data,
      projectsPath: projectsPath,
      withName: target.name
    )

    let arguments = [
      "-s", target.directory.string,
      "-d", destination,
      "--use-mock-observable",
      "--mock-final",
      "--custom-imports", target.name,
      "--exclude-imports",
      "NeedleFoundation",
      "AppFoundation",
      "AppResource",
      "DesignSystem",
      "Localization",
      "Network",
      "UIKit"
    ]

    return (destination, arguments)
  }

  private func destination(
    for target: SourceModuleTargetType,
    projectsPath: String,
    withName name: String
  ) -> String {
    let layer = target.directoryName

    let path: String
    switch target {
    case .feature:
      path = "\(projectsPath)/\(layer)/\(name)/Tests/\(name)Tests/"

    case .data:
      let module = String(name.dropLast("Data".count))
      path = "\(projectsPath)/\(layer)/\(module)/Tests/\(name)Tests/"

    case .featureInterface:
      let module = String(name.dropLast("Interface".count))
      path = "\(projectsPath)/\(layer)/\(module)/Sources/\(module)TestSupport/"

    case .domain:
      let module = String(name.dropLast("Domain".count))
      path = "\(projectsPath)/\(layer)/\(module)/Sources/\(name)TestSupport/"
    }

    let destination = "\(path)\(name)Mocks.swift"
    return destination
  }
}

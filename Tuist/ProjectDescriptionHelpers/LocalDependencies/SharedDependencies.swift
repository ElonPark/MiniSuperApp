//
//  SharedDependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Elon on 2022/12/26.
//

import ProjectDescription

public enum SharedDependencies: String, CaseIterable, Packageable {
  case appFoundation
  case platform
  case entity
  case appResource
  case designSystem
  case localization

  public var packageSource: Package {
    .package(path: .relativeToRoot("Projects/Shared"))
  }

  public static var allPackageSource: [Package] {
    [.package(path: .relativeToRoot("Projects/Shared"))]
  }
}

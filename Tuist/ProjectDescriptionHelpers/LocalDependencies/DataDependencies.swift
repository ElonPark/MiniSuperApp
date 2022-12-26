//
//  DataDependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Elon on 2022/12/26.
//

import ProjectDescription

// MARK: - DataDependencies

public enum DataDependencies: String, CaseIterable, Packageable {
  case bootstrapData

  public var packageSource: Package { .package(path: path) }
  private var path: Path { .relativeToRoot("Projects/Data/\(packageName)") }
}

// MARK: - DataDependencies.TestSupport

extension DataDependencies {
  public enum TestSupport: String, CaseIterable, Packageable {
    case bootstrapDomainTestSupport

    public var packageSource: Package { .package(path: path) }
    private var path: Path {
      let path = String(packageName.dropLast("DomainTestSupport".count))
      return .relativeToRoot("Projects/Data/\(path)")
    }
  }
}

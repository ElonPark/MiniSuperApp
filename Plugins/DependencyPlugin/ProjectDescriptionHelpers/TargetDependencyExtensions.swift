//
//  TargetDependencyExtensions.swift
//  DependencyPlugin
//
//  Created by Elon on 2023/09/29.
//

import ProjectDescription

extension TargetDependency {
  public static func external(dependencyName: ExternalDependency) -> TargetDependency {
    .external(name: dependencyName.rawValue)
  }
}

//
//  DependencyPluginExtensions.swift
//  DependencyPlugin
//
//  Created by Elon on 2023/09/29.
//

import ProjectDescription

// MARK: - GitCloneMode

public enum GitCloneMode {
  case https
  case ssh
}

extension Package {
  public static func github(
    cloneMode: GitCloneMode = .https,
    path: String,
    requirement: Requirement
  ) -> Package {
    .remote(url: githubURL(path: path, cloneMode: cloneMode), requirement: requirement)
  }

  static func githubURL(path: String, cloneMode: GitCloneMode) -> String {
    switch cloneMode {
    case .https: "https://github.com/\(path).git"
    case .ssh: "git@github.com:\(path).git"
    }
  }
}

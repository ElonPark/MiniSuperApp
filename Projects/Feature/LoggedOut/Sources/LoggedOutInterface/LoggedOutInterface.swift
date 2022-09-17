//
//  LoggedOutInterface.swift
//
//
//  Created by Elon on 2022/09/17.
//

import RIBs

// MARK: - LoggedOutListener

/// @mockable
public protocol LoggedOutListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

// MARK: - LoggedOutRouting

/// @mockable
public protocol LoggedOutRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

// MARK: - LoggedOutBuildDependency

public struct LoggedOutBuildDependency {
  public let listener: LoggedOutListener

  public init(listener: LoggedOutListener) {
    self.listener = listener
  }
}

// MARK: - LoggedOutBuildable

/// @mockable
public protocol LoggedOutBuildable: Buildable {
  func build(with dynamicBuildDependency: LoggedOutBuildDependency) -> LoggedOutRouting
}

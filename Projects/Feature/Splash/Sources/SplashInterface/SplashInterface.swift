//
//  SplashInterface.swift
//
//
//  Created by Elon on 2022/08/07.
//

import Foundation

import RIBs

// MARK: - SplashListener

/// @mockable
public protocol SplashListener: AnyObject {
  func initializationComplete()
}

// MARK: - SplashBuildDependency

public struct SplashBuildDependency {
  public let listener: SplashListener

  public init(listener: SplashListener) {
    self.listener = listener
  }
}

// MARK: - SplashRouting

/// @mockable
public protocol SplashRouting: ViewableRouting {}

// MARK: - SplashBuildable

/// @mockable
public protocol SplashBuildable: Buildable {
  func build(with dynamicBuildDependency: SplashBuildDependency) -> SplashRouting
}

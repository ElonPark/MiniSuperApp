//
//  SplashInterface.swift
//
//
//  Created by Elon on 2022/08/07.
//

import Foundation

import NeedleFoundation
import RIBs

// MARK: - SplashListener

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

public protocol SplashRouting: ViewableRouting {}

// MARK: - SplashBuildable

public protocol SplashBuildable: Buildable {
  func build(with dynamicBuildDependency: SplashBuildDependency) -> SplashRouting
}

//
//  LoggedOutBuilder.swift
//  LoggedOutSample
//
//  Created by Elon on 2022/09/18.
//  Copyright © 2022 com.elonpark. All rights reserved.
//

import NeedleFoundation
import RIBs

import AppFoundation
import LoggedOutInterface

// MARK: - LoggedOutDependency

public protocol LoggedOutDependency: NeedleFoundation.Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

// MARK: - DynamicComponentDependency

public typealias LoggedOutComponentDependency = Void

// MARK: - LoggedOutComponent

public final class LoggedOutComponent: NeedleFoundation.Component<LoggedOutDependency> {
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - LoggedOutBuilder

public final class LoggedOutBuilder:
  ComponentizedBuilder<
    LoggedOutComponent,
    LoggedOutRouting,
    LoggedOutBuildDependency,
    LoggedOutComponentDependency
  >,
  LoggedOutBuildable
{
  override public func build(
    with component: LoggedOutComponent,
    _ payload: LoggedOutBuildDependency
  ) -> LoggedOutRouting {
    let viewController = LoggedOutViewController()
    let interactor = LoggedOutInteractor(
      presenter: viewController
    )
    interactor.listener = payload.listener

    return LoggedOutRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}

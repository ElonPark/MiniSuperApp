//
//  RootBuilder.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/10.
//

import NeedleFoundation
import RIBs

// MARK: - Dependency

protocol RootDependency: NeedleFoundation.Dependency {

}

// MARK: - DynamicComponentDependency

typealias RootComponentDependency = Void

// MARK: - Component

final class RootComponent: NeedleFoundation.Component<RootDependency> {

}

// MARK: - DynamicBuildDependency

typealias RootBuildDependency = Void

// MARK: - Builder

protocol RootBuildable: Buildable {
  func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler)
}

final class RootBuilder:
  ComponentizedBuilder<
    RootComponent,
    (launchRouter: LaunchRouting, urlHandler: URLHandler),
    RootBuildDependency,
    RootComponentDependency
  >,
  RootBuildable
{

  override func build(
    with component: RootComponent,
    _ payload: RootBuildDependency
  ) -> (launchRouter: LaunchRouting, urlHandler: URLHandler) {
    let viewController = RootTabBarController()
    let interactor = RootInteractor(
      presenter: viewController
    )

    let router = RootRouter(
      interactor: interactor,
      viewController: viewController
    )

    return (router, interactor)
  }
}

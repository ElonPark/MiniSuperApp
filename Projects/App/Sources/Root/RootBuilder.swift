//
//  RootBuilder.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/21.
//  Copyright © 2022 elonpark. All rights reserved.
//

import NeedleFoundation
import RIBs

import AppFoundation
import SplashInterface

// MARK: - RootDependency

protocol RootDependency: NeedleFoundation.Dependency {
  var splashBuilder: SplashBuildable { get }
}

// MARK: - DynamicComponentDependency

typealias RootComponentDependency = Void

// MARK: - RootComponent

final class RootComponent: NeedleFoundation.Component<RootDependency> {}

// MARK: - DynamicBuildDependency

typealias RootBuildDependency = Void

// MARK: - RootBuildable

protocol RootBuildable: Buildable {
  func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler)
}

// MARK: - RootBuilder

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
      viewController: viewController,
      splashBuilder: component.splashBuilder
    )

    return (router, interactor)
  }
}

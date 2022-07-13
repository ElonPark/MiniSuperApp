//
//  SplashBuilder.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/13.
//

import NeedleFoundation
import RIBs

// MARK: - SplashDependency

protocol SplashDependency: NeedleFoundation.Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

// MARK: - DynamicComponentDependency

typealias SplashComponentDependency = Void

// MARK: - SplashComponent

final class SplashComponent: NeedleFoundation.Component<SplashDependency> {

  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - SplashBuildDependency

struct SplashBuildDependency {
  let listener: SplashListener
}

// MARK: - SplashBuildable

protocol SplashBuildable: Buildable {
  func build(with dynamicBuildDependency: SplashBuildDependency) -> SplashRouting
}

// MARK: - SplashBuilder

final class SplashBuilder:
  ComponentizedBuilder<
    SplashComponent,
    SplashRouting,
    SplashBuildDependency,
    SplashComponentDependency
  >,
  SplashBuildable
{

  override func build(
    with component: SplashComponent,
    _ payload: SplashBuildDependency
  ) -> SplashRouting {
    let viewController = SplashViewController()
    let interactor = SplashInteractor(
      presenter: viewController
    )
    interactor.listener = payload.listener

    return SplashRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}

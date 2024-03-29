//
//  RootRouter.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/21.
//  Copyright © 2022 elonpark. All rights reserved.
//

import RIBs

import SplashInterface

// MARK: - RootInteractable

/// @mockable
protocol RootInteractable: Interactable, SplashListener {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

// MARK: - RootViewControllable

/// @mockable
protocol RootViewControllable: ViewControllable {
  func present(_ viewControllable: ViewControllable, animated: Bool)
  func dismiss(_ viewController: ViewControllable, animated: Bool)
}

// MARK: - RootRouter

final class RootRouter:
  LaunchRouter<RootInteractable, RootViewControllable>,
  RootRouting
{

  private let splashBuilder: SplashBuildable
  var splashRouter: SplashRouting?

  init(
    interactor: RootInteractable,
    viewController: RootViewControllable,
    splashBuilder: SplashBuildable
  ) {
    self.splashBuilder = splashBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  func attachSplashRIB() {
    guard splashRouter == nil else { return }
    let router = splashBuilder.build(with: .init(listener: interactor))
    splashRouter = router
    attachChild(router)
    viewController.present(router.viewControllable, animated: false)
  }

  func detachSplashRIB() {
    guard let router = splashRouter else { return }
    splashRouter = nil
    detachChild(router)
    viewController.dismiss(router.viewControllable, animated: true)
  }
}

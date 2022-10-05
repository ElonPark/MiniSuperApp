//
//  RootRouter.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/21.
//  Copyright © 2022 elonpark. All rights reserved.
//

import RIBs

import LoggedOutInterface

// MARK: - RootInteractable

protocol RootInteractable: Interactable, LoggedOutListener {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {}

// MARK: - RootRouter

final class RootRouter:
  LaunchRouter<RootInteractable, RootViewControllable>,
  RootRouting
{

  private let loggedOutBuilder: LoggedOutBuildable
  private var loggedOutRouter: LoggedOutRouting?

  init(
    interactor: RootInteractable,
    viewController: RootViewControllable,
    loggedOutBuilder: LoggedOutBuildable
  ) {
    self.loggedOutBuilder = loggedOutBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  func attachLoggedOutRIB() {
    guard self.loggedOutRouter == nil else { return }
    let router = self.loggedOutBuilder.build(with: .init(listener: self.interactor))
    self.loggedOutRouter = router
    self.attachChild(router)
    self.viewController.present(router.viewControllable, animated: false)
  }

  func detachLoggedOutRIB() {
    guard let router = loggedOutRouter else { return }
    self.loggedOutRouter = nil
    self.detachChild(router)
    self.viewController.dismiss(router.viewControllable, animated: true)
  }
}

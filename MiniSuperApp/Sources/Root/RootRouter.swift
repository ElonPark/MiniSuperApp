//
//  RootRouter.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/10.
//

import RIBs

// MARK: - RootInteractable

protocol RootInteractable: Interactable {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {}

// MARK: - RootRouter

final class RootRouter:
  LaunchRouter<RootInteractable, RootViewControllable>,
  RootRouting
{

  override init(
    interactor: RootInteractable,
    viewController: RootViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}

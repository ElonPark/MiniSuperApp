//
//  SplashRouter.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/13.
//

import RIBs

// MARK: - SplashInteractable

protocol SplashInteractable: Interactable {
  var router: SplashRouting? { get set }
  var listener: SplashListener? { get set }
}

// MARK: - SplashViewControllable

protocol SplashViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

// MARK: - SplashRouter

final class SplashRouter:
  ViewableRouter<SplashInteractable, SplashViewControllable>,
  SplashRouting
{

  // TODO: Constructor inject child builder protocols to allow building children.
  override init(
    interactor: SplashInteractable,
    viewController: SplashViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}

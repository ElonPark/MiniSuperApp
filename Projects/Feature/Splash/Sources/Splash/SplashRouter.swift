//
//  SplashRouter.swift
//  SplashSample
//
//  Created by Elon on 2022/08/07.
//  Copyright © 2022 com.elonpark. All rights reserved.
//

import RIBs

import SplashInterface

// MARK: - SplashInteractable

protocol SplashInteractable: Interactable {
  var router: SplashRouting? { get set }
  var listener: SplashListener? { get set }
}

protocol SplashViewControllable: ViewControllable {}

// MARK: - SplashRouter

final class SplashRouter:
  ViewableRouter<SplashInteractable, SplashViewControllable>,
  SplashRouting
{

  override init(
    interactor: SplashInteractable,
    viewController: SplashViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}

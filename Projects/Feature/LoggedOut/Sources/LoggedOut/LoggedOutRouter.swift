//
//  LoggedOutRouter.swift
//  LoggedOutSample
//
//  Created by Elon on 2022/09/18.
//  Copyright © 2022 com.elonpark. All rights reserved.
//

import RIBs

import LoggedOutInterface

// MARK: - LoggedOutInteractable

protocol LoggedOutInteractable: Interactable {
  var router: LoggedOutRouting? { get set }
  var listener: LoggedOutListener? { get set }
}

// MARK: - LoggedOutViewControllable

protocol LoggedOutViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

// MARK: - LoggedOutRouter

final class LoggedOutRouter:
  ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>,
  LoggedOutRouting
{

  override init(
    interactor: LoggedOutInteractable,
    viewController: LoggedOutViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  func attachSignUpFlowRIB() {
    // TODO: - 구현 <Elon> 2022-10-03 23:15:50
  }

  func attachSignInFlowRIB() {
    // TODO: - 구현 <Elon> 2022-10-03 23:15:50
  }
}

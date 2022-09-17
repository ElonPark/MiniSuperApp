//
//  LoggedOutRouter.swift
//  LoggedOutSample
//
//  Created by Elon on 2022/09/18.
//  Copyright © 2022 com.elonpark. All rights reserved.
//

import RIBs

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
  // TODO: Constructor inject child builder protocols to allow building children.
  override init(
    interactor: LoggedOutInteractable,
    viewController: LoggedOutViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}

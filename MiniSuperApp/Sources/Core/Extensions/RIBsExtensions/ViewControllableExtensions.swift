//
//  ViewControllableExtensions.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/10.
//

import UIKit

import RIBs

extension ViewControllable {
  var navigationController: UINavigationController? {
    uiviewController as? UINavigationController ?? uiviewController.navigationController
  }

  func present(
    _ viewControllable: ViewControllable,
    animated: Bool,
    completion: (() -> Void)? = nil
  ) {
    self.uiviewController.present(
      viewControllable.uiviewController,
      animated: animated,
      completion: completion
    )
  }

  func dismiss(
    animated: Bool,
    completion: (() -> Void)? = nil
  ) {
    self.uiviewController.dismiss(
      animated: animated,
      completion: completion
    )
  }

  func pushViewController(
    _ viewControllable: ViewControllable,
    animated: Bool
  ) {
    self.navigationController?.pushViewController(
      viewControllable.uiviewController,
      animated: animated
    )
  }

  func popViewController(animated: Bool) {
    self.navigationController?.popViewController(
      animated: animated
    )
  }

  func popToRoot(animated: Bool) {
    self.navigationController?.popToRootViewController(
      animated: animated
    )
  }

  func setViewControllers(
    _ viewControllerables: [ViewControllable],
    animated: Bool
  ) {
    self.navigationController?.setViewControllers(
      viewControllerables.map(\.uiviewController),
      animated: animated
    )
  }
}

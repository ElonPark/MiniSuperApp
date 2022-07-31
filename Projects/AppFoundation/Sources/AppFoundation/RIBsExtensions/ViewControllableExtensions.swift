//
//  ViewControllableExtensions.swift
//
//
//  Created by Elon on 2022/07/21.
//

import UIKit

import RIBs

extension ViewControllable {
  public var navigationController: UINavigationController? {
    uiviewController as? UINavigationController ?? uiviewController.navigationController
  }

  public func present(
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

  public func dismiss(
    animated: Bool,
    completion: (() -> Void)? = nil
  ) {
    self.uiviewController.dismiss(
      animated: animated,
      completion: completion
    )
  }

  public func pushViewController(
    _ viewControllable: ViewControllable,
    animated: Bool
  ) {
    self.navigationController?.pushViewController(
      viewControllable.uiviewController,
      animated: animated
    )
  }

  public func popViewController(animated: Bool) {
    self.navigationController?.popViewController(
      animated: animated
    )
  }

  public func popToRoot(animated: Bool) {
    self.navigationController?.popToRootViewController(
      animated: animated
    )
  }

  public func setViewControllers(
    _ viewControllerables: [ViewControllable],
    animated: Bool
  ) {
    self.navigationController?.setViewControllers(
      viewControllerables.map(\.uiviewController),
      animated: animated
    )
  }
}

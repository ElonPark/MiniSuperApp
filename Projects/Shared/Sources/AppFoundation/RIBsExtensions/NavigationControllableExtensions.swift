//
//  NavigationControllable.swift
//
//
//  Created by elon on 2022/10/02.
//

import UIKit

import RIBs

extension UINavigationController: ViewControllable {

  public var uiviewController: UIViewController { return self }

  public convenience init(root: ViewControllable) {
    self.init(rootViewController: root.uiviewController)
  }
}

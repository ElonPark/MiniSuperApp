//
//  RootViewController.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/21.
//  Copyright © 2022 elonpark. All rights reserved.
//

import UIKit

import RIBs
import RxSwift

import AppResource
import DesignSystem

protocol RootPresentableListener: AnyObject {}

// MARK: - RootViewController

final class RootViewController:
  BaseViewController,
  RootPresentable,
  RootViewControllable
{

  weak var listener: RootPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Asset.Color.Static.blue
  }
}

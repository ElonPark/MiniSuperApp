//
//  RootTabBarController.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/21.
//  Copyright © 2022 elonpark. All rights reserved.
//

import UIKit

import RIBs
import RxSwift

import AppResource

protocol RootPresentableListener: AnyObject {}

// MARK: - RootTabBarController

final class RootTabBarController:
  UITabBarController,
  RootPresentable,
  RootViewControllable
{

  weak var listener: RootPresentableListener?

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Asset.Color.Semantic.background
  }
}

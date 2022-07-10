//
//  RootTabBarController.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/10.
//

import RIBs
import RxSwift
import UIKit

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
  }
}

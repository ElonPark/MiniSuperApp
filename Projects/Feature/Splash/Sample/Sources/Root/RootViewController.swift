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

// MARK: - RootPresentableListener

protocol RootPresentableListener: AnyObject {
  func startLaunchSequence()
}

// MARK: - RootViewController

final class RootViewController:
  BaseViewController,
  RootPresentable,
  RootViewControllable
{

  private let rootFlexContainer = UIView()
  private let button = UIButton().then {
    $0.setTitle("Show Splash", for: .normal)
  }

  weak var listener: RootPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Asset.Color.Static.blue
    defineLayout()
    addTarget()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    rootFlexContainer.pin.all()
    rootFlexContainer.flex.layout()
  }

  private func defineLayout() {
    view.addSubview(rootFlexContainer)
    rootFlexContainer.flex
      .justifyContent(.center)
      .alignItems(.center)
      .define {
        $0.addItem(self.button)
      }
  }

  private func addTarget() {
    button.addTarget(
      self,
      action: #selector(buttonAction),
      for: .touchUpInside
    )
  }

  @objc
  private func buttonAction() {
    listener?.startLaunchSequence()
  }
}

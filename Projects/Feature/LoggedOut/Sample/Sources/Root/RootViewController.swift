//
//  RootViewController.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/21.
//  Copyright © 2022 elonpark. All rights reserved.
//

import UIKit

import FlexLayout
import PinLayout
import RIBs
import RxSwift

import AppResource
import DesignSystem

// MARK: - RootPresentableListener

protocol RootPresentableListener: AnyObject {}

// MARK: - RootViewController

final class RootViewController:
  BaseViewController,
  RootPresentable,
  RootViewControllable
{
  private let rootFlexContainer = UIView()
  private let button = UIButton().then {
    $0.setTitle("Start", for: .normal)
  }

  weak var listener: RootPresentableListener?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = Asset.Color.Static.blue
    self.defineLayout()
    self.addTarget()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.rootFlexContainer.pin.all()
    self.rootFlexContainer.flex.layout()
  }

  private func defineLayout() {
    self.view.addSubview(self.rootFlexContainer)
    self.rootFlexContainer.flex
      .justifyContent(.center)
      .alignItems(.center)
      .define {
        $0.addItem(self.button)
      }
  }

  private func addTarget() {
    self.button.addTarget(
      self,
      action: #selector(self.buttonAction),
      for: .touchUpInside
    )
  }

  @objc
  private func buttonAction() {}
}

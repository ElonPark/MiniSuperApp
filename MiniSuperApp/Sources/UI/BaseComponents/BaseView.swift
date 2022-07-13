//
//  BaseView.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/13.
//

import UIKit

class BaseView: UIView {

  // MARK: UI

  let rootFlexContainer = UIView().then {
    $0.accessibilityIdentifier = "BaseView.rootFlexContainer"
  }

  // MARK: Initializing

  init() {
    super.init(frame: .zero)
    self.defineLayout()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func defineLayout() {
    self.addSubview(self.rootFlexContainer)
    // override here
  }
}

//
//  File.swift
//
//
//  Created by Elon on 2022/08/07.
//

import UIKit

import Then

import AppResource

open class BaseView: UIView {

  // MARK: UI

  public let rootFlexContainer = UIView().then {
    $0.accessibilityIdentifier = "rootFlexContainer"
  }

  // MARK: Initializing

  public init() {
    super.init(frame: .zero)
    self.accessibilityIdentifier = "\(type(of: self))"
    self.backgroundColor = Asset.Color.Semantic.background
    self.defineLayout()
  }

  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open func defineLayout() {
    self.addSubview(self.rootFlexContainer)
    // override here
  }
}

//
//  SplashView.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/13.
//

import UIKit

import FlexLayout
import PinLayout

final class SplashView: BaseView {

  // MARK: UI

  private let loadingIndicator = UIActivityIndicatorView(style: .large)

  override init() {
    super.init()
    self.backgroundColor = Asset.Color.Semantic.background
  }

  override func defineLayout() {
    super.defineLayout()
    self.rootFlexContainer.flex
      .justifyContent(.center)
      .alignItems(.center)
      .define {
        $0.addItem(self.loadingIndicator)
      }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.rootFlexContainer.pin.all()
    self.rootFlexContainer.flex.layout()
  }

  func startAnimating() {
    self.loadingIndicator.startAnimating()
  }

  func stopAnimating() {
    self.loadingIndicator.stopAnimating()
  }
}

//
//  SplashView.swift
//
//
//  Created by Elon on 2022/08/07.
//

import UIKit

import FlexLayout
import PinLayout

import AppResource
import DesignSystem
import Localization

final class SplashView: BaseView {

  // MARK: UI

  private let greetingLabel = BaseLabel().then {
    $0.text = L10n.Splash.greeting
    $0.font = SemanticFont.largeTitle
  }

  private let loadingIndicator = UIActivityIndicatorView(style: .large)

  override func defineLayout() {
    super.defineLayout()
    self.rootFlexContainer.flex
      .justifyContent(.center)
      .alignItems(.center)
      .define {
        $0.addItem(self.greetingLabel)
          .bottom(180.0)
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

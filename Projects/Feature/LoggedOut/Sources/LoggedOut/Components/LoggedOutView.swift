//
//  LoggedOutView.swift
//
//
//  Created by elon on 2022/10/02.
//

import UIKit

import FlexLayout
import PinLayout

import AppResource
import DesignSystem
import Localization

final class LoggedOutView: BaseView {

  let signUpButton = CornerRoundedButton().then {
    $0.backgroundColor = Asset.Color.Semantic.primary
    $0.setTitleColor(Asset.Color.Static.white, for: .normal)
    $0.setTitle(L10n.LoggedOut.signUp, for: .normal)
  }

  let signInButton = CornerRoundedButton(
    borderColor: Asset.Color.Semantic.gray,
    borderWidth: 0.5
  ).then {
    $0.backgroundColor = Asset.Color.Semantic.secondaryBackground
    $0.setTitleColor(Asset.Color.Semantic.label, for: .normal)
    $0.setTitle(L10n.LoggedOut.signIn, for: .normal)
  }

  override func defineLayout() {
    super.defineLayout()
    self.rootFlexContainer.flex
      .justifyContent(.center)
      .alignItems(.stretch)
      .define {
        $0.addItem()
          .justifyContent(.spaceBetween)
          .paddingHorizontal(32.0)
          .define {
            $0.addItem(self.signUpButton).define {
              $0.height(50.0)
            }
            .marginBottom(10.0)
            $0.addItem(self.signInButton).define {
              $0.height(50.0)
            }
          }
      }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.rootFlexContainer.pin.all()
    self.rootFlexContainer.flex.layout()
  }
}

//
//  LoggedOutViewController.swift
//  LoggedOutSample
//
//  Created by Elon on 2022/09/18.
//  Copyright © 2022 com.elonpark. All rights reserved.
//

import UIKit

import RIBs
import RxSwift

import DesignSystem

// MARK: - LoggedOutPresentableListener

protocol LoggedOutPresentableListener: AnyObject {
  func sendSignUpAction(_ action: LoggedOutModels.SignUp.Action)
  func sendSignInAction(_ action: LoggedOutModels.SignIn.Action)
}

// MARK: - LoggedOutViewController

final class LoggedOutViewController:
  BaseViewController,
  LoggedOutPresentable,
  LoggedOutViewControllable
{

  weak var listener: LoggedOutPresentableListener?

  private lazy var contentsView = LoggedOutView()

  override init() {
    super.init()
    modalPresentationStyle = .fullScreen
    modalTransitionStyle = .crossDissolve
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    view = contentsView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    addSignUpButtonAction()
    addSignInButtonAction()
  }

  private func addSignUpButtonAction() {
    contentsView.signUpButton.addAction(
      UIAction { [weak self] _ in
        self?.listener?.sendSignUpAction(.buttonClicked)
      },
      for: .primaryActionTriggered
    )
  }

  private func addSignInButtonAction() {
    contentsView.signInButton.addAction(
      UIAction { [weak self] _ in
        self?.listener?.sendSignInAction(.buttonClicked)
      },
      for: .primaryActionTriggered
    )
  }
}

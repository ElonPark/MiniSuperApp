//
//  SplashViewController.swift
//  SplashSample
//
//  Created by Elon on 2022/08/07.
//  Copyright © 2022 com.elonpark. All rights reserved.
//

import UIKit

import RIBs
import RxSwift

import DesignSystem
import Localization

protocol SplashPresentableListener: AnyObject {}

// MARK: - SplashViewController

final class SplashViewController:
  BaseViewController,
  SplashPresentable,
  SplashViewControllable
{

  weak var listener: SplashPresentableListener?

  private lazy var contentsView = SplashView()

  override init() {
    super.init()
    modalPresentationStyle = .fullScreen
    modalTransitionStyle = .crossDissolve
  }

  override func loadView() {
    view = contentsView
  }

  // MARK: SplashPresentable

  func displaySplash(viewModel: SplashModels.Splash.ViewModel) {
    if viewModel.isLoading {
      contentsView.startAnimating()
    } else {
      contentsView.stopAnimating()
    }
  }

  func displayBootstrap(viewModel: SplashModels.Bootstrap.ViewModel) {
    let alert = UIAlertController(
      title: nil,
      message: viewModel.errorMessage,
      preferredStyle: .alert
    )
    let okAction = UIAlertAction(title: L10n.Common.ok, style: .cancel) { _ in
      exit(0)
    }
    alert.addAction(okAction)

    present(alert, animated: true)
  }
}

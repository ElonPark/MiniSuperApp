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

protocol SplashPresentableListener: AnyObject {}

// MARK: - SplashViewController

final class SplashViewController:
  BaseViewController,
  SplashPresentable,
  SplashViewControllable
{

  weak var listener: SplashPresentableListener?

  private lazy var contentsView = SplashView()

  override func loadView() {
    self.view = self.contentsView
  }

  // MARK: SplashPresentable

  func displaySplash(viewModel: SplashModels.Splash.ViewModel) {
    if viewModel.isLoading {
      self.contentsView.startAnimating()
    } else {
      self.contentsView.stopAnimating()
    }
  }
}

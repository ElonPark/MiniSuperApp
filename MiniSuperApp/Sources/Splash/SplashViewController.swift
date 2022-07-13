//
//  SplashViewController.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/13.
//

import RIBs
import RxSwift
import UIKit

protocol SplashPresentableListener: AnyObject {}

// MARK: - SplashViewController

final class SplashViewController:
  UIViewController,
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

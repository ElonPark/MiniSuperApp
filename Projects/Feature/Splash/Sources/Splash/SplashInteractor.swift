//
//  SplashInteractor.swift
//  SplashSample
//
//  Created by Elon on 2022/08/07.
//  Copyright © 2022 com.elonpark. All rights reserved.
//

import Foundation

import RIBs
import RxSwift

import SplashInterface

// MARK: - SplashPresentable

/// @mockable
protocol SplashPresentable: Presentable {
  var listener: SplashPresentableListener? { get set }
  func displaySplash(viewModel: SplashModels.Splash.ViewModel)
  func displayBootstrap(viewModel: SplashModels.Bootstrap.ViewModel)
}

// MARK: - SplashInteractor

final class SplashInteractor:
  PresentableInteractor<SplashPresentable>,
  SplashInteractable,
  SplashPresentableListener
{

  private let bootstrapRepository: BootstrapRepository

  weak var router: SplashRouting?
  weak var listener: SplashListener?

  init(
    presenter: SplashPresentable,
    bootstrapRepository: BootstrapRepository
  ) {
    self.bootstrapRepository = bootstrapRepository
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
    self.startInitialization()
  }

  private func startInitialization() {
    self.displayLoading(true)
    self.bootstrapRepository.requestBootstrapping()
      .subscribe(with: self) { `self`, _ in
        self.listener?.initializationComplete()

      } onFailure: { `self`, error in
        print(error.localizedDescription)
        self.presentErrorAlert(with: error)

      } onDisposed: { `self` in
        self.displayLoading(false)
      }
      .disposeOnDeactivate(interactor: self)
  }

  private func displayLoading(_ isLoading: Bool) {
    self.presenter.displaySplash(
      viewModel: SplashModels.Splash.ViewModel(
        isLoading: isLoading
      )
    )
  }

  private func presentErrorAlert(with error: Error) {
    self.presenter.displayBootstrap(
      viewModel: SplashModels.Bootstrap.ViewModel(
        errorMessage: error.localizedDescription
      )
    )
  }
}

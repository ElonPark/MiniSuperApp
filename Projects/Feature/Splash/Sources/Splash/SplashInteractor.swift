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

protocol SplashPresentable: Presentable {
  var listener: SplashPresentableListener? { get set }
  func displaySplash(viewModel: SplashModels.Splash.ViewModel)
}

// MARK: - SplashInteractor

final class SplashInteractor:
  PresentableInteractor<SplashPresentable>,
  SplashInteractable,
  SplashPresentableListener
{

  weak var router: SplashRouting?
  weak var listener: SplashListener?

  override init(presenter: SplashPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
    self.startInitialization()
  }

  private func startInitialization() {
    self.presenter.displaySplash(viewModel: .init(isLoading: true))

    // TODO: 초기화 API 실행
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
      // TODO: - 초기화 완료 <Elon> 2022-07-13 23:38:35
      self.presenter.displaySplash(viewModel: .init(isLoading: false))
      self.listener?.initializationComplete()
    }
  }
}

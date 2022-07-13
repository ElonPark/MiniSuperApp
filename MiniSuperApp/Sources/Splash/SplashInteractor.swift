//
//  SplashInteractor.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/13.
//

import Foundation

import RIBs
import RxSwift

// MARK: - SplashRouting

protocol SplashRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

// MARK: - SplashPresentable

protocol SplashPresentable: Presentable {
  var listener: SplashPresentableListener? { get set }
  func displaySplash(viewModel: SplashModels.Splash.ViewModel)
}

// MARK: - SplashListener

protocol SplashListener: AnyObject {
  func initializationComplete()
}

// MARK: - SplashInteractor

final class SplashInteractor:
  PresentableInteractor<SplashPresentable>,
  SplashInteractable,
  SplashPresentableListener
{

  weak var router: SplashRouting?
  weak var listener: SplashListener?

  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: SplashPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
    self.startInitialization()
  }

  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
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

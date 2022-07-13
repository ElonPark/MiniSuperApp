//
//  RootInteractor.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/10.
//

import Foundation

import RIBs
import RxSwift

// MARK: - RootRouting

protocol RootRouting: ViewableRouting {
  func attachSplashRIB()
  func detachSplashRIB()
}

// MARK: - RootPresentable

protocol RootPresentable: Presentable {
  var listener: RootPresentableListener? { get set }
}

protocol RootListener: AnyObject {}

// MARK: - RootInteractor

final class RootInteractor:
  PresentableInteractor<RootPresentable>,
  RootInteractable,
  RootPresentableListener,
  URLHandler,
  SplashListener
{

  weak var router: RootRouting?
  weak var listener: RootListener?

  override init(presenter: RootPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
    self.startLaunchSequence()
  }

  private func startLaunchSequence() {
    self.router?.attachSplashRIB()
  }

  func initializationComplete() {
    // TODO: - 로그인 유무 판단 <Elon> 2022-07-14 01:06:37
    self.router?.detachSplashRIB()
  }
}

// MARK: - URLHandler

extension RootInteractor {
  func handle(_ url: URL) {
    // TODO: - handle DeepLink <Elon> 2022-07-10 02:59:50
  }
}

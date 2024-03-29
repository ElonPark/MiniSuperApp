//
//  RootInteractor.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/21.
//  Copyright © 2022 elonpark. All rights reserved.
//

import Foundation

import RIBs
import RxSwift

import AppFoundation

// MARK: - RootRouting

protocol RootRouting: ViewableRouting {
  func attachLoggedOutRIB()
  func detachLoggedOutRIB()
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
  URLHandler
{

  weak var router: RootRouting?
  weak var listener: RootListener?

  override init(presenter: RootPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
    router?.attachLoggedOutRIB()
  }

  func buttonTapAction() {
    router?.attachLoggedOutRIB()
  }
}

// MARK: - URLHandler

extension RootInteractor {
  func handle(_ url: URL) {}
}

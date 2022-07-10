//
//  RootInteractor.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/10.
//

import Foundation

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {}

protocol RootPresentable: Presentable {
  var listener: RootPresentableListener? { get set }
}

protocol RootListener: AnyObject {}

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

  }
}

// MARK: URLHandler

extension RootInteractor {
  func handle(_ url: URL) {
    // TODO: - handle DeepLink <Elon> 2022-07-10 02:59:50
  }
}

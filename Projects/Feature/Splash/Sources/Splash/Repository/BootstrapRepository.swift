//
//  BootstrapRepository.swift
//
//
//  Created by Elon on 2022/08/08.
//

import Foundation

import RxSwift

import NetworkInterface

// MARK: - BootstrapRepository

/// @mockable
protocol BootstrapRepository {
  func requestBootstrapping() -> Single<Void>
}

// MARK: - BootstrapRepositoryImpl

final class BootstrapRepositoryImpl: BootstrapRepository {

  private let network: Networking

  init(network: Networking) {
    self.network = network
  }

  func requestBootstrapping() -> Single<Void> {
    return self.network.request(BootstrapAPI.bootstrapping)
      .map { _ in Void() }
      .catchAndReturn(Void())
      .delaySubscription(.seconds(1), scheduler: MainScheduler.instance)
  }
}

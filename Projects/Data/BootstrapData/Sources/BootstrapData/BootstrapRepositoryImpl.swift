//
//  BootstrapRepositoryImpl.swift
//
//
//  Created by Elon on 2022/10/10.
//

import Foundation

import RxMoya
import RxSwift

import BootstrapDomain
import NetworkInterface

public final class BootstrapRepositoryImpl: BootstrapRepository {

  private let network: Networking

  public init(network: Networking) {
    self.network = network
  }

  public func requestBootstrapping() -> Single<BootstrapModel> {
    network.request(BootstrapAPI.bootstrapping)
      .map(BootstrapModel.self)
      .catchAndReturn(BootstrapModel())
      .delaySubscription(.seconds(1), scheduler: MainScheduler.instance)
  }
}

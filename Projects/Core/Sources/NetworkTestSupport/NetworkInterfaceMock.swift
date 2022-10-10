//
//  NetworkInterfaceMock.swift
//
//
//  Created by Elon on 2022/10/10.
//

import Foundation

import Moya
import RxSwift

import NetworkInterface

// MARK: - NetworkingMock

public final class NetworkingMock: Networking {
  public init() {}

  public private(set) var requestCallCount = 0
  public var requestHandler: ((TargetType) -> (Single<Response>))?
  public func request(_ target: TargetType) -> Single<Response> {
    self.requestCallCount += 1
    if let requestHandler = requestHandler {
      return requestHandler(target)
    }
    fatalError("requestHandler returns can't have a default value thus its handler must be set")
  }
}

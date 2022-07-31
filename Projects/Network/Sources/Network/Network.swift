//
//  Network.swift
//
//
//  Created by Elon on 2022/07/21.
//

import Moya
import RxMoya
import RxSwift

// MARK: - Networking

public protocol Networking {
  func request(_ target: TargetType) -> Single<Response>
}

// MARK: - Network

public final class Network: MoyaProvider<MultiTarget>, Networking {

  public func request(_ target: TargetType) -> Single<Response> {
    let multiTarget = Moya.MultiTarget.target(target)
    return self.rx.request(multiTarget)
  }
}

//
//  NetworkInterface.swift
//
//
//  Created by Elon on 2022/09/11.
//

import Foundation

import Moya
import RxSwift

// MARK: - Networking

public protocol Networking {
  func request(_ target: TargetType) -> Single<Response>
}

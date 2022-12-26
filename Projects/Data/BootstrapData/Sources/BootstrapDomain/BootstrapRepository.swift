//
//  BootstrapRepository.swift
//
//
//  Created by Elon on 2022/10/10.
//

import Foundation

import RxSwift

/// @mockable
public protocol BootstrapRepository {
  func requestBootstrapping() -> Single<BootstrapModel>
}

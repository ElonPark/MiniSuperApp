//
//  UserStreamInterface.swift
//
//
//  Created by Elon on 2022/09/12.
//

import Foundation

import RxSwift

// MARK: - UserStream

public protocol UserStream: AnyObject {
  var user: User? { get }
  var userObservable: Observable<User?> { get }
}

// MARK: - MutableUserStream

public protocol MutableUserStream: UserStream {
  func configure(user: User?)
}

//
//  UserStreamInterface.swift
//
//
//  Created by Elon on 2022/09/12.
//

import Foundation

import RxSwift

import Entity

// MARK: - UserStream

public protocol UserStream: AnyObject {
  var user: User? { get }
  var userObservable: Observable<User?> { get }
}

// MARK: - MutableUserStream

public protocol MutableUserStream: UserStream {
  func setUser(_ user: User?)
}
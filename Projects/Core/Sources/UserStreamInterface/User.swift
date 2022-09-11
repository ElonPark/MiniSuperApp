//
//  User.swift
//  UserStreamInterface
//
//  Created by Elon on 2022/07/19.
//

import Foundation

public struct User: Identifiable, Hashable, Equatable, Codable {

  public let id: Int
  public let name: String

  public init(
    id: Int,
    name: String
  ) {
    self.id = id
    self.name = name
  }
}

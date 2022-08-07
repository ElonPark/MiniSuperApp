//
//  User.swift
//  Entity
//
//  Created by Elon on 2022/07/19.
//

import Foundation

public struct User: Identifiable, Hashable, Equatable, Codable {

  public let id: Int
  public let name: String
  public let token: String

  public init(
    id: Int,
    name: String,
    token: String
  ) {
    self.id = id
    self.name = name
    self.token = token
  }
}

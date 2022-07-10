//
//  User.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/11.
//

import Foundation

public struct User: Identifiable, Codable {

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

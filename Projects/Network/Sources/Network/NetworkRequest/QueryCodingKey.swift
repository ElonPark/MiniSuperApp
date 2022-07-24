//
//  QueryCodingKey.swift
//
//
//  Created by Elon on 2022/07/24.
//

import Foundation

struct QueryCodingKey: CodingKey {
  let stringValue: String
  let intValue: Int?

  init(stringValue: String) {
    self.stringValue = stringValue
    self.intValue = Int(stringValue)
  }

  init(intValue: Int) {
    self.stringValue = "\(intValue)"
    self.intValue = intValue
  }

  init(key: CodingKeyRepresentable) {
    self.stringValue = key.codingKey.stringValue
    self.intValue = key.codingKey.intValue
  }
}

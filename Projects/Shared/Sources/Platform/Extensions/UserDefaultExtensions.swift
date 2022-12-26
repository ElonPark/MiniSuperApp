//
//  UserDefaultExtensions.swift
//  Platform
//
//  Created by Elon on 2022/07/19.
//

import Foundation

extension UserDefaults {
  public func setCodable(value: some Codable, for key: String, encoder: JSONEncoder = .init()) {
    let data = try? encoder.encode(value)
    setValue(data, forKey: key)
  }

  public func codable<Value: Codable>(for key: String, decoder: JSONDecoder = .init()) -> Value? {
    guard let data = data(forKey: key) else { return nil }
    return try? decoder.decode(Value.self, from: data)
  }
}

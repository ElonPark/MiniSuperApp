//
//  UserDefaultExtensions.swift
//  Platform
//
//  Created by Elon on 2022/07/19.
//

import Foundation

extension UserDefaults {
  public func setCodable(
    value: some Codable,
    forKey key: String,
    encoder: JSONEncoder = .init()
  ) {
    do {
      let data = try encoder.encode(value)
      setValue(data, forKey: key)
    } catch {
      print(error)
      assertionFailure(error.localizedDescription)
    }
  }

  public func codable<Value: Codable>(
    forKey key: String,
    decoder: JSONDecoder = .init()
  ) -> Value? {
    do {
      guard let data = data(forKey: key) else { return nil }
      return try decoder.decode(Value.self, from: data)
    } catch {
      print(error)
      assertionFailure(error.localizedDescription)
      return nil
    }
  }
}

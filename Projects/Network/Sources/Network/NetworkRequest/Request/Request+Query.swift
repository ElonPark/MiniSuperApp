//
//  Request+Query.swift
//
//
//  Created by Elon on 2022/07/24.
//

import Foundation

extension Request {
  public struct Query<Key: Encodable> {

    // MARK: - Types

    public struct Parameter<K, V> {
      public var key: K
      public var value: V
    }

    // MARK: - Properties

    private var elements: [Element]

    // MARK: - Lifecycle

    init<S: Sequence>(uniqueKeysWithValues elements: S) where S.Element == (Key, Value) {
      self.elements = elements.map(Parameter.init)
    }

    // MARK: - Methods

    public subscript(key: Key) -> Value? where Key: Equatable {
      get { self.elements.first { $0.key == key }?.value }
      set {
        if let index = elements.firstIndex(where: { $0.key == key }) {
          if let newValue = newValue {
            self.elements[index].value = newValue
          } else {
            self.elements.remove(at: index)
          }
        } else {
          if let newValue = newValue {
            self.elements.append(Element(key: key, value: newValue))
          }
        }
      }
    }
  }
}

// MARK: - Request.Query + ExpressibleByDictionaryLiteral

extension Request.Query: ExpressibleByDictionaryLiteral {
  public typealias Value = any Encodable

  public init(dictionaryLiteral elements: (Key, Value)...) {
    self.elements = elements.map(Parameter.init)
  }
}

// MARK: - Request.Query + RangeReplaceableCollection

extension Request.Query: RangeReplaceableCollection {
  public init() {
    self.elements = []
  }
}

// MARK: - Request.Query + Sequence

extension Request.Query: Sequence {
  public typealias Iterator = IndexingIterator<[Element]>

  public func makeIterator() -> Iterator {
    return elements.makeIterator()
  }
}

// MARK: - Request.Query + Collection

extension Request.Query: Collection {
  public typealias Element = Parameter<Key, Value>
  public typealias Index = Int

  public var startIndex: Index {
    return elements.startIndex
  }

  public var endIndex: Int {
    return elements.endIndex
  }

  public subscript(position: Int) -> Element {
    return elements[position]
  }

  public func index(after i: Int) -> Int {
    return elements.index(after: i)
  }
}

extension Request.Query where Key == String {
  public func encode(to url: URL, encoding: QueryEncoding) -> URL? {
    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
    components?.queryItems = elements.flatMap { encodeQueryItem(element: $0, encoding: encoding) }
    return components?.url
  }

  private func encodeQueryItem(element: Element, encoding: QueryEncoding) -> [URLQueryItem] {
    self.encodeQueryItem(name: element.key, value: element.value, encoding: encoding)
  }

  private func encodeQueryItem(name: String, value: Any, encoding: QueryEncoding) -> [URLQueryItem] {
    switch value {
    case let boolean as Bool:
      let queryItem = self.encodeBool(name: name, value: boolean, encoding: encoding)
      return [queryItem]
    case let number as NSNumber:
      let queryItem = self.encodeNumber(name: name, value: number)
      return [queryItem]
    case let array as [Any]:
      let queryItems = self.encodeArray(name: name, value: array, encoding: encoding)
      return queryItems
    case let dictionary as [String: Any]:
      let queryItems = self.encodeDictionary(name: name, value: dictionary, encoding: encoding)
      return queryItems
    default:
      let queryItem = URLQueryItem(name: name, value: "\(value)")
      return [queryItem]
    }
  }

  private func encodeBool(name: String, value: Bool, encoding: QueryEncoding) -> URLQueryItem {
    let stringValue: String

    switch encoding.bool {
    case .numeric:
      stringValue = (value as NSNumber).stringValue
    case .literal:
      stringValue = String(value)
    }

    return URLQueryItem(name: name, value: stringValue)
  }

  private func encodeNumber(name: String, value: NSNumber) -> URLQueryItem {
    let stringValue = value.stringValue
    return URLQueryItem(name: name, value: stringValue)
  }

  private func encodeArray(name: String, value: [Any], encoding: QueryEncoding) -> [URLQueryItem] {
    switch encoding.array {
    case .enclosingBrackets:
      return value.flatMap { encodeQueryItem(name: name + "[]", value: $0, encoding: encoding) }
    case .surroundingBrackets:
      let value = value
        .flatMap { encodeQueryItem(name: name, value: $0, encoding: encoding) }
        .compactMap(\.value)
        .map { "\"\($0)\"" }
        .joined(separator: ",")

      let queryItem = URLQueryItem(name: name, value: "[\(value)]")
      return [queryItem]
    case .noBrackets:
      return value.flatMap { encodeQueryItem(name: name, value: $0, encoding: encoding) }
    }
  }

  private func encodeDictionary(name: String, value: [String: Any], encoding: QueryEncoding) -> [URLQueryItem] {
    return value
      .map { encodeQueryItem(name: name + "[\($0)]", value: $1, encoding: encoding) }
      .flatMap { $0 }
  }
}

// MARK: - Request.Query + Encodable

extension Request.Query: Encodable {
  public func encode(to encoder: Encoder) throws {
    if Key.self is CodingKeyRepresentable.Type {
      var container = encoder.container(keyedBy: QueryCodingKey.self)

      for element in elements {
        guard let key = element.key as? CodingKeyRepresentable else {
          continue
        }

        let codingKey = QueryCodingKey(key: key)
        try container.encode(element.value, forKey: codingKey)
      }
    } else {
      var container = encoder.unkeyedContainer()

      for element in elements {
        try container.encode(element.key)
        try container.encode(element.value)
      }
    }
  }
}

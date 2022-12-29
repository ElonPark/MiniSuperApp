//
//  AnyKeyValuePair.swift
//
//
//  Created by Elon on 2022/12/29.
//

import Foundation

public protocol AnyKeyValuePair {
  var parameterizedKey: ParameterizedKey { get }
  var anyValue: Any { get }
}

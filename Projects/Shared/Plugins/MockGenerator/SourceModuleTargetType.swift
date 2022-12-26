//
//  SourceModuleTargetType.swift
//
//
//  Created by Elon on 2022/12/26.
//

import Foundation

enum SourceModuleTargetType {
  case feature
  case featureInterface
  case domain
  case data

  var directoryName: String {
    switch self {
    case .feature, .featureInterface:
      return "Feature"

    case .data, .domain:
      return "Data"
    }
  }
}

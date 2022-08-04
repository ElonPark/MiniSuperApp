//
//  RemoteDependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Elon on 2022/08/05.
//

import ProjectDescription

// MARK: - RemoteDependencies

public enum RemoteDependencies: String, CaseIterable, Packageable {
  case rxSwift
  case ribs = "RIBs"
  case needleFoundation
  case flexLayout
  case pinLayout
  case then

  public var packageSource: Package {
    switch self {
    case .rxSwift:
      return .remote(url: "\(self.github)/ReactiveX/RxSwift.git", requirement: .upToNextMajor(from: "6.5.0"))
    case .ribs:
      return .remote(url: "\(self.github)/uber/RIBs.git", requirement: .branch("main"))
    case .needleFoundation:
      return .remote(url: "\(self.github)/uber/needle.git", requirement: .upToNextMajor(from: "0.18.1"))
    case .flexLayout:
      return .remote(url: "\(self.github)/layoutBox/FlexLayout.git", requirement: .upToNextMajor(from: "1.3.24"))
    case .pinLayout:
      return .remote(url: "\(self.github)/layoutBox/PinLayout.git", requirement: .upToNextMajor(from: "1.10.3"))
    case .then:
      return .remote(url: "\(self.github)/devxoul/Then", requirement: .upToNextMajor(from: "3.0.0"))
    }
  }
}

extension RemoteDependencies {
  var github: String { "https://github.com" }
}

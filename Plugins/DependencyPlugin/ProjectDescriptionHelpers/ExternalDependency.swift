import ProjectDescription

// MARK: - ExternalDependency

public enum ExternalDependency: String, Hashable, CaseIterable {
  case RxSwift
  case RIBs
  case NeedleFoundation
  case FlexLayout
  case PinLayout
  case Then
}

// MARK: - ExternalDependency.Package

extension ExternalDependency {
  static func package(for dependency: ExternalDependency) -> Package {
    switch dependency {
    case .RxSwift: .github(
        path: "ReactiveX/RxSwift",
        requirement: .upToNextMajor(from: "6.5.0")
      )
    case .RIBs: .github(
        path: "uber/RIBs",
        requirement: .branch("main")
      )
    case .NeedleFoundation: .github(
        path: "uber/needle",
        requirement: .upToNextMajor(from: "0.18.1")
      )
    case .FlexLayout: .github(
        path: "layoutBox/FlexLayout",
        requirement: .upToNextMajor(from: "1.3.24")
      )
    case .PinLayout: .github(
        path: "layoutBox/PinLayout",
        requirement: .upToNextMajor(from: "1.10.3")
      )
    case .Then: .github(
        path: "devxoul/Then",
        requirement: .upToNextMajor(from: "3.0.0")
      )
    }
  }
}

// MARK: - ExternalDependency.ProductType

extension ExternalDependency {
  static var externalProductTypes: [ExternalDependency: Product] {
    [
      .Then: .framework,
    ]
  }
}

// MARK: - public

extension ExternalDependency {
  public static var packages: [Package] {
    ExternalDependency.allCases.map(Self.package)
  }

  public static var productTypes: [String: Product] {
    externalProductTypes.reduce(into: [String: Product]()) {
      $0[$1.key.rawValue] = $1.value
    }
  }
}

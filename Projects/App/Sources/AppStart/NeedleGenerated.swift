

import AppFoundation
import Foundation
import NeedleFoundation
import Network
import RIBs
import SplashInterface

// swiftlint:disable unused_declaration
private let needleDependenciesHash: String? = nil

// MARK: - Registration

public func registerProviderFactories() {
  __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent") { component in
    return EmptyDependencyProvider(component: component)
  }
  __DependencyProviderRegistry.instance
    .registerDependencyProviderFactory(for: "^->AppComponent->RootComponent") { component in
      return RootDependency3944cc797a4a88956fb5Provider(component: component)
    }
}

// MARK: - RootDependency3944cc797a4a88956fb5BaseProvider

private class RootDependency3944cc797a4a88956fb5BaseProvider: RootDependency {

  init() {}
}

// MARK: - RootDependency3944cc797a4a88956fb5Provider

/// ^->AppComponent->RootComponent
private class RootDependency3944cc797a4a88956fb5Provider: RootDependency3944cc797a4a88956fb5BaseProvider {
  init(component: NeedleFoundation.Scope) {
    super.init()
  }
}

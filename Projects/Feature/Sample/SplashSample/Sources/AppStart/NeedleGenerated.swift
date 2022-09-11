

import AppFoundation
import Foundation
import NeedleFoundation
import Network
import NetworkInterface
import RIBs
import Splash
import SplashInterface

// swiftlint:disable unused_declaration
private let needleDependenciesHash: String? = nil

// MARK: - Registration

public func registerProviderFactories() {
  __DependencyProviderRegistry.instance
    .registerDependencyProviderFactory(for: "^->SplashSampleAppComponent->SplashComponent") { component in
      return SplashDependencyf7dba9fd3ca54c8769deProvider(component: component)
    }
  __DependencyProviderRegistry.instance
    .registerDependencyProviderFactory(for: "^->SplashSampleAppComponent") { component in
      return EmptyDependencyProvider(component: component)
    }
  __DependencyProviderRegistry.instance
    .registerDependencyProviderFactory(for: "^->SplashSampleAppComponent->RootComponent") { component in
      return RootDependency2dd76bccd0c17471e840Provider(component: component)
    }
}

// MARK: - SplashDependencyf7dba9fd3ca54c8769deBaseProvider

private class SplashDependencyf7dba9fd3ca54c8769deBaseProvider: SplashDependency {
  var network: Networking {
    return self.splashSampleAppComponent.network
  }

  private let splashSampleAppComponent: SplashSampleAppComponent
  init(splashSampleAppComponent: SplashSampleAppComponent) {
    self.splashSampleAppComponent = splashSampleAppComponent
  }
}

// MARK: - SplashDependencyf7dba9fd3ca54c8769deProvider

/// ^->SplashSampleAppComponent->SplashComponent
private class SplashDependencyf7dba9fd3ca54c8769deProvider: SplashDependencyf7dba9fd3ca54c8769deBaseProvider {
  init(component: NeedleFoundation.Scope) {
    super.init(splashSampleAppComponent: component.parent as! SplashSampleAppComponent)
  }
}

// MARK: - RootDependency2dd76bccd0c17471e840BaseProvider

private class RootDependency2dd76bccd0c17471e840BaseProvider: RootDependency {
  var splashBuilder: SplashBuildable {
    return self.splashSampleAppComponent.splashBuilder
  }

  private let splashSampleAppComponent: SplashSampleAppComponent
  init(splashSampleAppComponent: SplashSampleAppComponent) {
    self.splashSampleAppComponent = splashSampleAppComponent
  }
}

// MARK: - RootDependency2dd76bccd0c17471e840Provider

/// ^->SplashSampleAppComponent->RootComponent
private class RootDependency2dd76bccd0c17471e840Provider: RootDependency2dd76bccd0c17471e840BaseProvider {
  init(component: NeedleFoundation.Scope) {
    super.init(splashSampleAppComponent: component.parent as! SplashSampleAppComponent)
  }
}

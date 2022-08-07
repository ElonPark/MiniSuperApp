

import AppFoundation
import Foundation
import NeedleFoundation
import RIBs
import Splash
import SplashInterface

// swiftlint:disable unused_declaration
private let needleDependenciesHash: String? = nil

// MARK: - Registration

public func registerProviderFactories() {
  __DependencyProviderRegistry.instance
    .registerDependencyProviderFactory(for: "^->AppComponent->SplashComponent") { component in
      return SplashDependencye0cb7136f2ec3edfd60aProvider(component: component)
    }
  __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent") { component in
    return EmptyDependencyProvider(component: component)
  }
  __DependencyProviderRegistry.instance
    .registerDependencyProviderFactory(for: "^->AppComponent->RootComponent") { component in
      return RootDependency3944cc797a4a88956fb5Provider(component: component)
    }
}

// MARK: - SplashDependencye0cb7136f2ec3edfd60aBaseProvider

private class SplashDependencye0cb7136f2ec3edfd60aBaseProvider: SplashDependency {

  init() {}
}

// MARK: - SplashDependencye0cb7136f2ec3edfd60aProvider

/// ^->AppComponent->SplashComponent
private class SplashDependencye0cb7136f2ec3edfd60aProvider: SplashDependencye0cb7136f2ec3edfd60aBaseProvider {
  init(component: NeedleFoundation.Scope) {
    super.init()
  }
}

// MARK: - RootDependency3944cc797a4a88956fb5BaseProvider

private class RootDependency3944cc797a4a88956fb5BaseProvider: RootDependency {
  var splashBuilder: SplashBuildable {
    return self.appComponent.splashBuilder
  }

  private let appComponent: AppComponent
  init(appComponent: AppComponent) {
    self.appComponent = appComponent
  }
}

// MARK: - RootDependency3944cc797a4a88956fb5Provider

/// ^->AppComponent->RootComponent
private class RootDependency3944cc797a4a88956fb5Provider: RootDependency3944cc797a4a88956fb5BaseProvider {
  init(component: NeedleFoundation.Scope) {
    super.init(appComponent: component.parent as! AppComponent)
  }
}

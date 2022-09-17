

import AppFoundation
import Foundation
import LoggedOut
import LoggedOutInterface
import NeedleFoundation
import Network
import NetworkInterface
import RIBs

// swiftlint:disable unused_declaration
private let needleDependenciesHash: String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
  return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

  private class RootDependency3944cc797a4a88956fb5Provider: RootDependency {
    var loggedOutBuilder: LoggedOutBuildable {
      return self.appComponent.loggedOutBuilder
    }

    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
      self.appComponent = appComponent
    }
  }

  /// ^->AppComponent->RootComponent
  private func factory264bfc4d4cb6b0629b40f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RootDependency3944cc797a4a88956fb5Provider(appComponent: parent1(component) as! AppComponent)
  }

  private class LoggedOutDependency2bcab0d3625f6f252479Provider: LoggedOutDependency {

    init() {}
  }

  /// ^->AppComponent->LoggedOutComponent
  private func factory686d1be2403fe94ce10ee3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return LoggedOutDependency2bcab0d3625f6f252479Provider()
  }

#else
  extension AppComponent: Registration {
    public func registerItems() {}
  }

  extension RootComponent: Registration {
    public func registerItems() {
      keyPathToName[\RootDependency.loggedOutBuilder] = "loggedOutBuilder-LoggedOutBuildable"
    }
  }

  extension LoggedOutComponent: Registration {
    public func registerItems() {}
  }

#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
  return EmptyDependencyProvider(component: component)
}

// MARK: - Registration

private func registerProviderFactory(
  _ componentPath: String,
  _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject
) {
  __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

  private func register1() {
    registerProviderFactory("^->AppComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->AppComponent->RootComponent", factory264bfc4d4cb6b0629b40f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->LoggedOutComponent", factory686d1be2403fe94ce10ee3b0c44298fc1c149afb)
  }
#endif

public func registerProviderFactories() {
  #if !NEEDLE_DYNAMIC
    register1()
  #endif
}

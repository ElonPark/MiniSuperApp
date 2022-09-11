///
/// @Generated by Mockolo
///

import AppTestSupport
import Foundation
import RIBs
import RxRelay
import RxSwift
import SplashInterface

// MARK: - SplashListenerMock

public final class SplashListenerMock: SplashListener {
  public init() {}

  public private(set) var initializationCompleteCallCount = 0
  public var initializationCompleteHandler: (() -> ())?
  public func initializationComplete() {
    self.initializationCompleteCallCount += 1
    if let initializationCompleteHandler = initializationCompleteHandler {
      initializationCompleteHandler()
    }
  }
}

// MARK: - SplashRoutingMock

public final class SplashRoutingMock: SplashRouting {
  public init() {}
  public init(
    lifecycle: Observable<RouterLifecycle> = PublishSubject<RouterLifecycle>(),
    viewControllable: ViewControllable = ViewControllableMock(),
    interactable: Interactable = InteractableMock(),
    children: [Routing] = [Routing]()
  ) {
    self.lifecycle = lifecycle
    self.viewControllable = viewControllable
    self.interactable = interactable
    self.children = children
  }

  private var lifecycleSubjectKind = 0
  public private(set) var lifecycleSubjectSetCallCount = 0
  public var lifecycleSubject = PublishSubject<RouterLifecycle>() { didSet { lifecycleSubjectSetCallCount += 1 } }
  public var lifecycleReplaySubject = ReplaySubject<RouterLifecycle>
    .create(bufferSize: 1) { didSet { self.lifecycleSubjectSetCallCount += 1 } }
  public var lifecycleBehaviorSubject: BehaviorSubject<RouterLifecycle>! {
    didSet { self.lifecycleSubjectSetCallCount += 1 }
  }

  public var _lifecycle: Observable<RouterLifecycle>! { didSet { self.lifecycleSubjectSetCallCount += 1 } }
  public var lifecycle: Observable<RouterLifecycle> {
    get {
      if self.lifecycleSubjectKind == 0 {
        return self.lifecycleSubject
      } else if self.lifecycleSubjectKind == 1 {
        return self.lifecycleBehaviorSubject
      } else if self.lifecycleSubjectKind == 2 {
        return self.lifecycleReplaySubject
      } else {
        return self._lifecycle
      }
    }
    set {
      if let val = newValue as? PublishSubject<RouterLifecycle> {
        self.lifecycleSubject = val
        self.lifecycleSubjectKind = 0
      } else if let val = newValue as? BehaviorSubject<RouterLifecycle> {
        self.lifecycleBehaviorSubject = val
        self.lifecycleSubjectKind = 1
      } else if let val = newValue as? ReplaySubject<RouterLifecycle> {
        self.lifecycleReplaySubject = val
        self.lifecycleSubjectKind = 2
      } else {
        self._lifecycle = newValue
        self.lifecycleSubjectKind = 3
      }
    }
  }

  public private(set) var viewControllableSetCallCount = 0
  public var viewControllable: ViewControllable = ViewControllableMock() {
    didSet { self.viewControllableSetCallCount += 1 }
  }

  public private(set) var interactableSetCallCount = 0
  public var interactable: Interactable = InteractableMock() { didSet { self.interactableSetCallCount += 1 } }
  public private(set) var childrenSetCallCount = 0
  public var children: [Routing] = .init() { didSet { self.childrenSetCallCount += 1 } }
  public private(set) var loadCallCount = 0
  public var loadHandler: (() -> Void)?
  public func load() {
    self.loadCallCount += 1
    if let loadHandler = loadHandler {
      loadHandler()
    }
  }

  public private(set) var attachChildCallCount = 0
  public var attachChildHandler: ((Routing) -> Void)?
  public func attachChild(_ child: Routing) {
    self.attachChildCallCount += 1
    if let attachChildHandler = attachChildHandler {
      attachChildHandler(child)
    }
  }

  public private(set) var detachChildCallCount = 0
  public var detachChildHandler: ((Routing) -> Void)?
  public func detachChild(_ child: Routing) {
    self.detachChildCallCount += 1
    if let detachChildHandler = detachChildHandler {
      detachChildHandler(child)
    }
  }
}

// MARK: - SplashBuildableMock

public final class SplashBuildableMock: SplashBuildable {
  public init() {}

  public private(set) var buildCallCount = 0
  public var buildHandler: ((SplashBuildDependency) -> (SplashRouting))?
  public func build(with dynamicBuildDependency: SplashBuildDependency) -> SplashRouting {
    self.buildCallCount += 1
    if let buildHandler = buildHandler {
      return buildHandler(dynamicBuildDependency)
    }
    return SplashRoutingMock()
  }
}
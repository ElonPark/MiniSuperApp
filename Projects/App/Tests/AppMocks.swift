//
// @Generated by Mockolo
//

import AppTestSupport
import Foundation
import RIBs
import RxRelay
import RxSwift
import SplashInterface
import UIKit
@testable import MiniSuperApp

// MARK: - RootInteractableMock

final class RootInteractableMock: RootInteractable {
  init() {}
  init(
    router: RootRouting? = nil,
    listener: RootListener? = nil,
    isActive: Bool = false,
    isActiveStream: Observable<Bool> = PublishSubject<Bool>()
  ) {
    self.router = router
    self.listener = listener
    self.isActive = isActive
    self.isActiveStream = isActiveStream
  }

  public private(set) var initializationCompleteCallCount = 0

  private(set) var routerSetCallCount = 0
  var router: RootRouting? { didSet { routerSetCallCount += 1 } }

  private(set) var listenerSetCallCount = 0
  var listener: RootListener? { didSet { listenerSetCallCount += 1 } }
  public var initializationCompleteHandler: (() -> ())?
  public func initializationComplete() {
    initializationCompleteCallCount += 1
    if let initializationCompleteHandler {
      initializationCompleteHandler()
    }
  }

  public private(set) var isActiveSetCallCount = 0
  public var isActive: Bool = false { didSet { isActiveSetCallCount += 1 } }
  private var isActiveStreamSubjectKind = 0
  public private(set) var isActiveStreamSubjectSetCallCount = 0
  public var isActiveStreamSubject = PublishSubject<Bool>() { didSet { isActiveStreamSubjectSetCallCount += 1 } }
  public var isActiveStreamReplaySubject = ReplaySubject<Bool>
    .create(bufferSize: 1) { didSet { isActiveStreamSubjectSetCallCount += 1 } }
  public var isActiveStreamBehaviorSubject: BehaviorSubject<Bool>! {
    didSet { isActiveStreamSubjectSetCallCount += 1 }
  }

  public var _isActiveStream: Observable<Bool>! { didSet { isActiveStreamSubjectSetCallCount += 1 } }
  public var isActiveStream: Observable<Bool> {
    get {
      if isActiveStreamSubjectKind == 0 {
        return isActiveStreamSubject
      } else if isActiveStreamSubjectKind == 1 {
        return isActiveStreamBehaviorSubject
      } else if isActiveStreamSubjectKind == 2 {
        return isActiveStreamReplaySubject
      } else {
        return _isActiveStream
      }
    }
    set {
      if let val = newValue as? PublishSubject<Bool> {
        isActiveStreamSubject = val
        isActiveStreamSubjectKind = 0
      } else if let val = newValue as? BehaviorSubject<Bool> {
        isActiveStreamBehaviorSubject = val
        isActiveStreamSubjectKind = 1
      } else if let val = newValue as? ReplaySubject<Bool> {
        isActiveStreamReplaySubject = val
        isActiveStreamSubjectKind = 2
      } else {
        _isActiveStream = newValue
        isActiveStreamSubjectKind = 3
      }
    }
  }

  public private(set) var activateCallCount = 0
  public var activateHandler: (() -> Void)?
  public func activate() {
    activateCallCount += 1
    if let activateHandler {
      activateHandler()
    }
  }

  public private(set) var deactivateCallCount = 0
  public var deactivateHandler: (() -> Void)?
  public func deactivate() {
    deactivateCallCount += 1
    if let deactivateHandler {
      deactivateHandler()
    }
  }
}

// MARK: - RootRoutingMock

final class RootRoutingMock: RootRouting {
  init() {}
  init(
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

  private(set) var attachSplashRIBCallCount = 0
  var attachSplashRIBHandler: (() -> ())?
  func attachSplashRIB() {
    attachSplashRIBCallCount += 1
    if let attachSplashRIBHandler {
      attachSplashRIBHandler()
    }
  }

  private(set) var detachSplashRIBCallCount = 0
  var detachSplashRIBHandler: (() -> ())?
  func detachSplashRIB() {
    detachSplashRIBCallCount += 1
    if let detachSplashRIBHandler {
      detachSplashRIBHandler()
    }
  }

  private var lifecycleSubjectKind = 0
  public private(set) var lifecycleSubjectSetCallCount = 0
  public var lifecycleSubject = PublishSubject<RouterLifecycle>() { didSet { lifecycleSubjectSetCallCount += 1 } }
  public var lifecycleReplaySubject = ReplaySubject<RouterLifecycle>
    .create(bufferSize: 1) { didSet { lifecycleSubjectSetCallCount += 1 } }
  public var lifecycleBehaviorSubject: BehaviorSubject<RouterLifecycle>! {
    didSet { lifecycleSubjectSetCallCount += 1 }
  }

  public var _lifecycle: Observable<RouterLifecycle>! { didSet { lifecycleSubjectSetCallCount += 1 } }
  public var lifecycle: Observable<RouterLifecycle> {
    get {
      if lifecycleSubjectKind == 0 {
        return lifecycleSubject
      } else if lifecycleSubjectKind == 1 {
        return lifecycleBehaviorSubject
      } else if lifecycleSubjectKind == 2 {
        return lifecycleReplaySubject
      } else {
        return _lifecycle
      }
    }
    set {
      if let val = newValue as? PublishSubject<RouterLifecycle> {
        lifecycleSubject = val
        lifecycleSubjectKind = 0
      } else if let val = newValue as? BehaviorSubject<RouterLifecycle> {
        lifecycleBehaviorSubject = val
        lifecycleSubjectKind = 1
      } else if let val = newValue as? ReplaySubject<RouterLifecycle> {
        lifecycleReplaySubject = val
        lifecycleSubjectKind = 2
      } else {
        _lifecycle = newValue
        lifecycleSubjectKind = 3
      }
    }
  }

  public private(set) var viewControllableSetCallCount = 0
  public var viewControllable: ViewControllable = ViewControllableMock() {
    didSet { viewControllableSetCallCount += 1 }
  }

  public private(set) var interactableSetCallCount = 0
  public var interactable: Interactable = InteractableMock() { didSet { interactableSetCallCount += 1 } }
  public private(set) var childrenSetCallCount = 0
  public var children: [Routing] = .init() { didSet { childrenSetCallCount += 1 } }
  public private(set) var loadCallCount = 0
  public var loadHandler: (() -> Void)?
  public func load() {
    loadCallCount += 1
    if let loadHandler {
      loadHandler()
    }
  }

  public private(set) var attachChildCallCount = 0
  public var attachChildHandler: ((Routing) -> Void)?
  public func attachChild(_ child: Routing) {
    attachChildCallCount += 1
    if let attachChildHandler {
      attachChildHandler(child)
    }
  }

  public private(set) var detachChildCallCount = 0
  public var detachChildHandler: ((Routing) -> Void)?
  public func detachChild(_ child: Routing) {
    detachChildCallCount += 1
    if let detachChildHandler {
      detachChildHandler(child)
    }
  }
}

// MARK: - RootPresentableMock

final class RootPresentableMock: RootPresentable {
  init() {}
  init(listener: RootPresentableListener? = nil) {
    self.listener = listener
  }

  private(set) var listenerSetCallCount = 0
  var listener: RootPresentableListener? { didSet { listenerSetCallCount += 1 } }
}

// MARK: - RootViewControllableMock

final class RootViewControllableMock: RootViewControllable {
  init() {}
  init(uiviewController: UIViewController = UIViewController()) {
    self.uiviewController = uiviewController
  }

  private(set) var presentCallCount = 0
  var presentHandler: ((ViewControllable, Bool) -> ())?
  func present(_ viewControllable: ViewControllable, animated: Bool) {
    presentCallCount += 1
    if let presentHandler {
      presentHandler(viewControllable, animated)
    }
  }

  private(set) var dismissCallCount = 0
  var dismissHandler: ((ViewControllable, Bool) -> ())?
  func dismiss(_ viewController: ViewControllable, animated: Bool) {
    dismissCallCount += 1
    if let dismissHandler {
      dismissHandler(viewController, animated)
    }
  }

  public private(set) var uiviewControllerSetCallCount = 0
  public var uiviewController: UIViewController = .init() { didSet { uiviewControllerSetCallCount += 1 } }
}

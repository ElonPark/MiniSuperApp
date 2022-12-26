//
// @Generated by Mockolo
//

import AppTestSupport
import Foundation
import LoggedOutInterface
import RIBs
import RxRelay
import RxSwift
@testable import LoggedOut

// MARK: - LoggedOutListenerMock

public final class LoggedOutListenerMock: LoggedOutListener {
  public init() {}
}

// MARK: - LoggedOutPresentableMock

final class LoggedOutPresentableMock: LoggedOutPresentable {
  init() {}
  init(listener: LoggedOutPresentableListener? = nil) {
    self.listener = listener
  }

  private(set) var listenerSetCallCount = 0
  var listener: LoggedOutPresentableListener? { didSet { listenerSetCallCount += 1 } }
}

// MARK: - LoggedOutRoutingMock

public final class LoggedOutRoutingMock: LoggedOutRouting {
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

  public private(set) var attachSignUpFlowRIBCallCount = 0
  public var attachSignUpFlowRIBHandler: (() -> ())?
  public func attachSignUpFlowRIB() {
    attachSignUpFlowRIBCallCount += 1
    if let attachSignUpFlowRIBHandler {
      attachSignUpFlowRIBHandler()
    }
  }

  public private(set) var attachSignInFlowRIBCallCount = 0
  public var attachSignInFlowRIBHandler: (() -> ())?
  public func attachSignInFlowRIB() {
    attachSignInFlowRIBCallCount += 1
    if let attachSignInFlowRIBHandler {
      attachSignInFlowRIBHandler()
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

// MARK: - LoggedOutBuildableMock

public final class LoggedOutBuildableMock: LoggedOutBuildable {
  public init() {}

  public private(set) var buildCallCount = 0
  public var buildHandler: ((LoggedOutBuildDependency) -> (LoggedOutRouting))?
  public func build(with dynamicBuildDependency: LoggedOutBuildDependency) -> LoggedOutRouting {
    buildCallCount += 1
    if let buildHandler {
      return buildHandler(dynamicBuildDependency)
    }
    return LoggedOutRoutingMock()
  }
}

//
//  SplashBuilder.swift
//  SplashSample
//
//  Created by Elon on 2022/08/07.
//  Copyright © 2022 com.elonpark. All rights reserved.
//

import NeedleFoundation
import RIBs

import AppFoundation
import BootstrapDomain
import SplashInterface

// MARK: - SplashDependency

public protocol SplashDependency: NeedleFoundation.Dependency {
  var bootstrapRepository: BootstrapRepository { get }
}

// MARK: - DynamicComponentDependency

public typealias SplashComponentDependency = Void

// MARK: - SplashComponent

public final class SplashComponent: NeedleFoundation.Component<SplashDependency> {}

// MARK: - SplashBuilder

public final class SplashBuilder:
  ComponentizedBuilder<
    SplashComponent,
    SplashRouting,
    SplashBuildDependency,
    SplashComponentDependency
  >,
  SplashBuildable
{

  override public func build(
    with component: SplashComponent,
    _ payload: SplashBuildDependency
  ) -> SplashRouting {
    let viewController = SplashViewController()
    let interactor = SplashInteractor(
      presenter: viewController,
      bootstrapRepository: component.bootstrapRepository
    )
    interactor.listener = payload.listener

    return SplashRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}

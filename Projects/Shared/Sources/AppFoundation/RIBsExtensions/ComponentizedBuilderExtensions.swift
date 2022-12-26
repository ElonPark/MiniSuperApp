//
//  ComponentizedBuilderExtensions.swift
//
//
//  Created by Elon on 2022/07/21.
//

import UIKit

import RIBs

extension ComponentizedBuilder {
  public final func build(
    with dynamicBuildDependency: DynamicBuildDependency,
    _ dynamicComponentDependency: DynamicComponentDependency
  ) -> Router {
    return build(
      withDynamicBuildDependency: dynamicBuildDependency,
      dynamicComponentDependency: dynamicComponentDependency
    )
  }
}

// MARK: - SimpleComponentizedBuilder

extension ComponentizedBuilder
  where DynamicComponentDependency == Void,
  DynamicBuildDependency == Void
{
  public final func build() -> Router {
    return build(
      withDynamicBuildDependency: Void(),
      dynamicComponentDependency: Void()
    )
  }
}

// MARK: - DynamicBuildComponentizedBuilder

extension ComponentizedBuilder where DynamicComponentDependency == Void {
  public final func build(
    with dynamicBuildDependency: DynamicBuildDependency
  ) -> Router {
    return build(
      withDynamicBuildDependency: dynamicBuildDependency,
      dynamicComponentDependency: Void()
    )
  }
}

// MARK: - DynamicComponentizedBuilder

extension ComponentizedBuilder where DynamicBuildDependency == Void {
  public final func build(
    with dynamicComponentDependency: DynamicComponentDependency
  ) -> Router {
    return build(
      withDynamicBuildDependency: Void(),
      dynamicComponentDependency: dynamicComponentDependency
    )
  }
}

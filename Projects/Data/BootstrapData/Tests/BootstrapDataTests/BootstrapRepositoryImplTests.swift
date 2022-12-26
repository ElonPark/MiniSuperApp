//
//  BootstrapRepositoryImplTests.swift
//
//
//  Created by Elon on 2022/10/10.
//

import XCTest

import Moya

import NetworkTestSupport
@testable import BootstrapData

final class BootstrapRepositoryImplTests: XCTestCase {

  var network: NetworkingMock!
  var repository: BootstrapRepositoryImpl!

  override func setUpWithError() throws {
    try super.setUpWithError()
    network = NetworkingMock()
    repository = BootstrapRepositoryImpl(network: network)
  }

  func test_requestBootstrapping_when_success() async throws {
    // given 성공 응답일때
    network.requestHandler = { _ in
      return .just(Response(statusCode: 200, data: Data()))
    }

    // when requestBootstrapping 호출하면
    let result: Error?
    do {
      _ = try await repository.requestBootstrapping().value
      result = nil
    } catch {
      result = error
    }

    // then 에러를 반환하지 않아요
    XCTAssertEqual(network.requestCallCount, 1)
    XCTAssertNil(result)
  }

  func test_requestBootstrapping_when_error() async throws {
    // given 에러 응답일때
    network.requestHandler = { _ in
      return .error(URLError(.badServerResponse))
    }

    // when requestBootstrapping 호출하면
    let result: Error?
    do {
      _ = try await repository.requestBootstrapping().value
      result = nil
    } catch {
      result = error
    }

    // then 에러를 반환하지 않아요
    XCTAssertEqual(network.requestCallCount, 1)
    XCTAssertNil(result)
  }
}

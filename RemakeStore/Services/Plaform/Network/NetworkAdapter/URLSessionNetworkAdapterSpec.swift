//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import Foundation

import RxSwift
@testable import RemakeStore

class URLSessionNetworkAdapterSpec: XCTestCase {

  var disposeBag: DisposeBag?
  var networkActivityMock: NetworkActivityMock?
  var sut: URLSessionNetworkAdapter?
  let stubServer = StubServer()

  override func setUp() {
    super.setUp()
    disposeBag = DisposeBag()
    networkActivityMock = NetworkActivityMock(with: 0)
    stubServer.setup()
  }

  override func tearDown() {
    super.tearDown()
    disposeBag = nil
    networkActivityMock = nil
    sut = nil
    stubServer.tearDown()
  }

  func test_inject_mock_init() {

    let expectedError = XCTestExpectation(description: "called the error event")
    let expectedServer = XCTestExpectation(description: "called the server event")

    guard
      let disposeBag = disposeBag,
      let networkActivityMock = networkActivityMock
      else {
        fatalError("Should net be nil")
    }

    guard let errorUrl = URL(string: "http://localhost:8080") else {
      fatalError("Should net be nil")
    }

    let session = URLSession(configuration: makeDefaultSessionConfig())
    sut = URLSessionNetworkAdapter(networkActivity: networkActivityMock, session: session)

    guard let sut = sut else {
      fatalError("Should net be nil")
    }

    DispatchQueue.main.async {

      sut.rx_send(request: URLRequest(url: errorUrl))
        .subscribe(
          onNext: { response in
            XCTAssertNil(response)
          }, onError: { err in
            XCTAssertNotNil(err)
            expectedError.fulfill()
          }).disposed(by: disposeBag)

      sut.rx_send(request: URLRequest(url: self.stubServer.getDefault()))
        .subscribe(
          onNext: { response in
            XCTAssertNotNil(response)
            expectedServer.fulfill()
          }, onError: { err in
            XCTAssertNil(err)
          }).disposed(by: disposeBag)

    }

    wait(for: [expectedError, expectedServer], timeout: 5.0)
  }

  private func makeDefaultSessionConfig() -> URLSessionConfiguration {
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForRequest = 30
    sessionConfig.timeoutIntervalForResource = 30
    return sessionConfig
  }
}

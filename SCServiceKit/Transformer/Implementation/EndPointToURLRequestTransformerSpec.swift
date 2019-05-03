//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import Foundation

import RxSwift

@testable import SCServiceKit

class EndPointToURLRequestTransformerSpec: XCTestCase {

  var disposeBag: DisposeBag?
  var mock: EndpointMock?
  var sut: EndPointToURLRequestTransformer?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    mock = nil
    sut = nil
    disposeBag = nil
  }

  func test_inject_param_non_optional_request() {
    let expectedMethod = HTTPMethod.GET
    let expectedBaseURL = "https://test.com/case1"
    let expectedHeader: [String: String] = [:]

    mock = EndpointMock(baseURL: "https://test.com", path: "case1", httpMethod: expectedMethod)
    sut = EndPointToURLRequestTransformer()

    guard
      let mock = mock,
      let sut = sut
      else {
      fatalError("Should be not nil")
    }

    do {

      let request = try sut.transform(object: mock)

      XCTAssertEqual(expectedHeader, request.allHTTPHeaderFields)
      XCTAssertNil(request.httpBody)
      XCTAssertEqual(expectedBaseURL, request.url?.absoluteString)
      XCTAssertEqual(expectedMethod.rawValue, request.httpMethod)

    } catch {
      XCTAssertNil(error)
    }
  }

  func test_inject_param_non_optional_rx_request() {

    let expectedMethod = HTTPMethod.GET
    let expectedBaseURL = "https://test.com/case1"
    let expectedHeader: [String: String] = [:]
    let expectedCall = XCTestExpectation(description: "called event")

    mock = EndpointMock(baseURL: "https://test.com", path: "case1", httpMethod: expectedMethod)
    sut = EndPointToURLRequestTransformer()
    disposeBag = DisposeBag()
    guard
      let mock = mock,
      let sut = sut,
      let disposeBag = disposeBag
      else {
        fatalError("Should be not nil")
    }

    sut.rx_transform(object: mock)
      .subscribe(onNext: { request in

        XCTAssertEqual(expectedHeader, request.allHTTPHeaderFields)
        XCTAssertNil(request.httpBody)
        XCTAssertEqual(expectedBaseURL, request.url?.absoluteString)
        XCTAssertEqual(expectedMethod.rawValue, request.httpMethod)

        expectedCall.fulfill()

      }).disposed(by: disposeBag)

    wait(for: [expectedCall], timeout: 5.0)

  }

  func test_inject_incorrect_param_non_optional_request() {

    let expectedMethod = HTTPMethod.GET

    mock = EndpointMock(
      baseURL: "",
      path: "case1",
      httpMethod: expectedMethod
    )
    sut = EndPointToURLRequestTransformer()
    guard
      let mock = mock,
      let sut = sut
      else {
        fatalError("Should be not nil")
    }

    do {
      let request = try sut.transform(object: mock)
      XCTAssertNil(request)
    } catch {
      XCTAssertNotNil(error)
    }

  }

  func test_inject_param_fullfill_request() {

    let expectedMethod = HTTPMethod.POST
    let expectedBaseURL = "https://test.com/case1?path=test"
    let expectedQueryParameters = ["path": "test"]
    let expectedHeaders = ["cookieId": "123123"]
    let expectedBodyParameters = ["password": "123123"]

    mock = EndpointMock(
      baseURL: "https://test.com",
      path: "case1",
      httpMethod: expectedMethod,
      queryParameters: expectedQueryParameters,
      headers: expectedHeaders,
      bodyParameters: expectedBodyParameters
    )
    sut = EndPointToURLRequestTransformer()
    guard
      let mock = mock,
      let sut = sut
      else {
        fatalError("Should be not nil")
    }

    do {
      let request = try sut.transform(object: mock)
      XCTAssertEqual(expectedHeaders, request.allHTTPHeaderFields)
      XCTAssertNotNil(request.httpBody)
      XCTAssertEqual(expectedBaseURL, request.url?.absoluteString)
      XCTAssertEqual(expectedMethod.rawValue, request.httpMethod)
    } catch {
      XCTAssertNil(error)
    }

  }

}

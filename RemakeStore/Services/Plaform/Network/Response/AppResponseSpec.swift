//
// Created by Scott Moon on 2019-04-30.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

private enum NetworkErrorMock: Error {
  case dataEmpty
  case dataInvalid
  case responseInvalid
  case statusCode(Int)
}

class AppResponseTest: XCTestCase {

  var sut: AppResponse?

  override class func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_inject_request_init() {

    let expectedRequest = self.makeRequest("https://test.com")
    let expectedSucceed = false

    sut = AppResponse(request: expectedRequest)

    guard let sut = sut else {
      return XCTFail("should be not nil")
    }

    XCTAssertEqual(expectedSucceed, sut.succeed)
    XCTAssertEqual(expectedRequest, sut.request)
    XCTAssertNil(sut.data)
    XCTAssertNil(sut.error)
    XCTAssertNil(sut.statusCode)
    XCTAssertNil(sut.headers)
  }

  func test_inject_success_state_param_init() {

    let expectedUrl = makeURL("https://test.com")
    let request = makeRequest("https://test.com")
    let expectedSucceed = true
    let expectedHeader = ["Cookie": "sessionId=123123"]
    let expectedStatusCode = HTTPStatusCode.ok.rawValue
    let expectedData = "😀".data(using: .utf8)

    let response = HTTPURLResponse(
      url: expectedUrl,
      statusCode: expectedStatusCode,
      httpVersion: "HTTP 1.1",
      headerFields: expectedHeader
    )

    sut = AppResponse(
      request: request,
      data: expectedData,
      httpResponse: response
    )

    guard let sut = sut else {
      return XCTFail("should be not nil")
    }

    XCTAssertEqual(expectedSucceed, sut.succeed)
    XCTAssertEqual(expectedStatusCode, sut.statusCode?.rawValue)
    XCTAssertEqual(expectedData, sut.data)
    XCTAssertEqual(expectedHeader["Cookie"], sut.headers?["Cookie"] as? String)
    XCTAssertNil(sut.error)

  }

  func test_inject_undefined_status_code_succeed_state_init() {

    let expectedUrl = makeURL("https://test.com")
    let request = makeRequest("https://test.com")
    let expectedSucceed = true
    let expectedHeader = ["Cookie": "sessionId=123123"]
    let expectedStatusCode = 302 // Redirection
    let expectedData = "😀".data(using: .utf8)

    let response = HTTPURLResponse(
      url: expectedUrl,
      statusCode: expectedStatusCode,
      httpVersion: "HTTP 1.1",
      headerFields: expectedHeader
    )

    sut = AppResponse(
      request: request,
      data: expectedData,
      httpResponse: response
    )

    guard let sut = sut else {
      return XCTFail("should be not nil")
    }

    XCTAssertEqual(expectedSucceed, sut.succeed)
    XCTAssertNil(sut.statusCode?.rawValue)
    XCTAssertEqual(expectedData, sut.data)
    XCTAssertEqual(expectedHeader["Cookie"], sut.headers?["Cookie"] as? String)
    XCTAssertNil(sut.error)

  }

  func test_inject_error_param_init() {

    let request = makeRequest("https://test.com")
    let expectedSucceed = false
    let statusCode = HTTPStatusCode.internalServerError.rawValue
    let error = NetworkErrorMock.statusCode(statusCode)

    sut = AppResponse(request: request, error: error)

    guard let sut = sut else {
      fatalError()
    }

    XCTAssertEqual(expectedSucceed, sut.succeed)
    XCTAssertNil(sut.statusCode?.rawValue)
    XCTAssertNil(sut.data)
    XCTAssertNil(sut.headers)
    XCTAssertNotNil(sut.error)

  }

  func makeURL(_ strURL: String) -> URL {
    guard let url = URL(string: strURL) else {
      fatalError("url is nil")
    }
    return url
  }

  func makeRequest(_ strURL: String) -> URLRequest {
    guard let url = URL(string: strURL) else {
      fatalError("url is nil")
    }
    return URLRequest(url: url)
  }

}

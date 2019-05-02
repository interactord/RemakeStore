//
// Created by Scott Moon on 2019-05-01.
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

class NetworkErrorSpec: XCTestCase {

  var sut: NetworkError?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_inject_nil_init() {

    let expectedKey = "error.global.network"
    sut = NetworkError()

    XCTAssertNil(sut?.raw)
    XCTAssertEqual(expectedKey, sut?.messageKey)
  }

  func test_inject_error_init() {

    let expectedKey = "error.global.network"
    let expectedError = NetworkErrorMock.dataEmpty
    sut = NetworkError(error: expectedError)

    guard let sutError = sut?.raw as? NetworkErrorMock else {
      XCTFail("should be not nil")
      return
    }

    XCTAssertEqual(expectedError.localizedDescription, sutError.localizedDescription)
    XCTAssertEqual(expectedKey, sut?.messageKey)
  }
}

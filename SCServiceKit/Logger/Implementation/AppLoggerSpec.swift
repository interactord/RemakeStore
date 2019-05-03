//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import SCServiceKit

class AppLoggerSpec: XCTestCase {

  var sut: AppLogger?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_no_inject_init() {
    let expect = false
    sut = AppLogger()

    XCTAssertEqual(expect, sut?.isEnvUsable())
  }

  func test_inject_init() {
    let mock = AppLoggerConfig(appId: "11", appSecret: "111", encryptionKey: "111")
    let expect = true

    sut = AppLogger(with: mock)

    XCTAssertEqual(expect, sut?.isEnvUsable())
  }

  func test_call_log() {

    sut = AppLogger()

    guard let sut = sut else {
      XCTFail("no initialized")
      return
    }

    sut.log(level: .debug, message: "test debug")
    sut.log(level: .verbose, message: "test verbose")
    sut.log(level: .info, message: "test info")
    sut.log(level: .warning, message: "test warning")
    sut.log(level: .error, message: "test error")
  }
}

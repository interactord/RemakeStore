//
// Created by Scott Moon on 2019-05-21.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class SearchFlowSpec: XCTestCase {
  var sut: SearchFlow?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func test_init() {
    let service = makeService()
    sut = SearchFlow(with: service)

    XCTAssertNotNil(sut)
  }

  func test_navigate() {
    let service = makeService()
    sut = SearchFlow(with: service)

    XCTAssertNotNil(sut?.navigate(to: AppStep.dashboardIsComplete))
    XCTAssertNotNil(sut?.navigate(to: AppStep.appDetailIsRequired(appId: 123)))
    XCTAssertNotNil(sut?.navigate(to: AppStep.appDetailIsComplete))
    XCTAssertNotNil(sut?.navigate(to: AppStep.todayDetailIsComplete))
  }

  func makeService() -> Service {
    var serviceDIContainer = ServiceDIContainer()
    return serviceDIContainer.service
  }
}

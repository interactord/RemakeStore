//
//  TodayFlowSpec.swift
//  RemakeStoreTests
//
//  Created by Scott Moon on 21/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class AppsFlowSpec: XCTestCase {
  var sut: AppsFlow?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func test_init() {
    let service = makeService()
    sut = AppsFlow(with: service)

    XCTAssertNotNil(sut)
  }

  func test_navigate() {
    let service = makeService()
    sut = AppsFlow(with: service)

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

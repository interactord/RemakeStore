//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayViewModelSpec: XCTestCase {

  var sut: TodayViewModel?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = makeSUT()
    XCTAssertNotNil(sut)
  }

  func test_inputs_outputs() {
    sut = makeSUT()
    _ = sut?.inputs
    _ = sut?.outputs
  }

  func makeSUT() -> TodayViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service
    let rssRepository = RssRepository(httpClient: service.httpClient, baseURL: "http://localhost:7000")
    let interactordRepository = InteractordRepository(httpClient: service.httpClient, baseUrl: "http://localhost:7000")

    return TodayViewModel(
      with: service,
      interactordRepository: interactordRepository,
      rssRepository: rssRepository
    )
  }
}

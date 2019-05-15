//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class AppsControllerSpec: XCTestCase {
  var sut: AppsController?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_viewDidLoad() {
    sut = AppsController()
    sut?.viewDidLoad()

    XCTAssertNotNil(sut)
  }

  func test_bind() {
    sut = AppsController()
    sut?.bind(to: makeViewModel())

    XCTAssertNotNil(sut)
  }

  func test_setConstant() {
    sut = AppsController()
    sut?.setupConstraints()
    XCTAssertNotNil(sut)
  }

  func makeViewModel() -> AppsViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service
    let rssRepository = RssRepository(httpClient: service.httpClient, baseURL: "http://localhost:7000")
    let interactordRepository = InteractordRepository(httpClient: service.httpClient, baseUrl: "http://localhost:7000")

    return AppsViewModel(
      with: service, rssRepository: rssRepository, interactordRepository: interactordRepository
    )
  }
}

//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayControllerSpec: XCTestCase {

  var sut: TodayController?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = TodayController()
    XCTAssertNotNil(sut)
  }

  func test_viewDidLoad() {
    sut = TodayController()
    sut?.viewDidLoad()
    XCTAssertNotNil(sut)
  }

  func test_setupConstraints() {
    sut = TodayController()
    sut?.setupConstraints()
    XCTAssertNotNil(sut)
  }

  func test_bind() {
    let viewModel = makeViewModel()
    sut = TodayController()
    sut?.viewModel = viewModel
    sut?.bind(to: viewModel)
  }

  func makeViewModel() -> TodayViewModel {
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

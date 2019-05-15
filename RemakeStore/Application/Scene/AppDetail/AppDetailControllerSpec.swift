//
// Created by Scott Moon on 2019-05-12.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import SCServiceKit
@testable import RemakeStore

class AppDetailControllerSpec: XCTestCase {
  var sut: AppDetailController?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_bind() {
    sut = AppDetailController()
    let viewModel = makeViewModel()
    sut?.viewModel = viewModel

    sut?.bind(to: viewModel)

    XCTAssertNotNil(sut)
  }

  func test_setupConstraints() {
    let viewModel = makeViewModel()

    sut = AppDetailController()
    sut?.viewModel = viewModel

    sut?.updateViewConstraints()
    XCTAssertNotNil(sut)
  }

  func makeViewModel() -> AppDetailViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service
    let baseUrl = "http://localhost:7000"
    let repository = ITunesRepository(
      httpClient: service.httpClient,
      baseUrl: baseUrl
    )

    return AppDetailViewModel(
      with: service,
      repository: repository
    )
  }

}

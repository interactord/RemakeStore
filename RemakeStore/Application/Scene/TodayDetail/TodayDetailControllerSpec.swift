//
// Created by Scott Moon on 2019-05-19.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayDetailControllerSpec: XCTestCase {

  var sut: TodayDetailController?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = TodayDetailController()
    sut?.viewDidLoad()
    sut?.setupConstraints()

    XCTAssertNotNil(sut)
  }

  func test_bind() {
    let viewModel = makeViewModel()
    sut = TodayDetailController()
    sut?.bind(to: viewModel)

    XCTAssertNotNil(sut)
  }

  func makeViewModel() -> TodayDetailViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service

    return TodayDetailViewModel(with: service)
  }

}

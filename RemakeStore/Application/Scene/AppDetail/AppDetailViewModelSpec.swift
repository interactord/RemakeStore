//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class AppDetailViewModelSpec: XCTestCase {

  var serviceDiContainer = ServiceDIContainer()
  lazy var service = serviceDiContainer.service
  var controller: AppDetailController?
  var sut: AppDetailViewModel?

  override func setUp() {
    super.setUp()

    sut = AppDetailViewModel(with: service)
    controller = AppDetailController()

    guard let sut = sut else {
      fatalError("Should be not nil")
    }

    controller?.viewModel = sut
    controller?.bind(to: sut)
  }

  override func tearDown() {
    super.tearDown()
    controller = nil
    sut = nil
  }

  func test_init() {

  }

}

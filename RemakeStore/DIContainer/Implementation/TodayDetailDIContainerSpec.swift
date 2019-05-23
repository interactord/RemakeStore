//
// Created by Scott Moon on 2019-05-21.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayDetailDIContainerSpec: XCTestCase {
  var sut: TodayDetailDIContainer?
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

  func test_controller() {
    sut = makeSUT()

    let controller = sut?.getController()
    XCTAssertNotNil(controller)
  }

  func makeSUT() -> TodayDetailDIContainer {
    let service = makeService()
    let todayItemViewModel = makeTodayItemViewModel()
    return TodayDetailDIContainer(with: service, todayItemViewModel: todayItemViewModel)
  }

  func makeService() -> Service {
    var serviceDIContainer = ServiceDIContainer()
    return serviceDIContainer.service
  }

  private func makeTodayItemViewModel() -> TodayItemViewModeling {
    let bundleUrl = Bundle.main.url(forResource: "todayItemsDummy", withExtension: "json")
    guard
      let url = bundleUrl,
      let todayItems = try? JSONDecoder().decode([TodayItem].self, from: Data(contentsOf: url)),
      let item = todayItems.first
      else {
        fatalError("Should be not nil")
    }

    return TodayItemViewModel(withTodayItem: item)
  }
}

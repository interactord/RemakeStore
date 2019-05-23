//
// Created by Scott Moon on 2019-05-19.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayDetailViewModelSpec: XCTestCase {

  var sut: TodayDetailViewModel?

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

  func makeSUT() -> TodayDetailViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service
    guard let todayItemViewModel = makeTodayItemViewModels()?.first else {
      fatalError("Should be not nil")
    }

    return TodayDetailViewModel(with: service, todayItemViewModel: todayItemViewModel)
  }

  private func makeTodayItemViewModels() -> [TodayItemViewModeling]? {
    let bundleUrl = Bundle.main.url(forResource: "todayItemsDummy", withExtension: "json")
    guard
      let url = bundleUrl,
      let todayItems = try? JSONDecoder().decode([TodayItem].self, from: Data(contentsOf: url))
      else {
        fatalError("Should be not nil")
    }

    return todayItems.map {
      TodayItemViewModel(withTodayItem: $0)
    }
  }

}

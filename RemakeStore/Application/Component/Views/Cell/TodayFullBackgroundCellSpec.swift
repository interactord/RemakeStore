//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayFullBackgroundCellSpec: XCTestCase {
  var sut: TodayFullBackgroundCell?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = TodayFullBackgroundCell()
    XCTAssertNotNil(sut)
  }

  func test_bindToViewModel() {
    sut = TodayFullBackgroundCell()
    sut?.bind(to: makeViewModel())

    XCTAssertNotNil(sut)
  }

  func makeViewModel() -> TodayItemViewModeling {
    let items = makeTodayItems()
    guard let item = items.first else {
      fatalError("Should be not nil")
    }
    return TodayItemViewModel(withTodayItem: item)
  }

  func makeTodayItems() -> [TodayItem] {
    let bundleUrl = Bundle.main.url(forResource: "todayItemsDummy", withExtension: "json")
    guard let url = bundleUrl else {
      fatalError("Should be not nil")
    }
    let todayItems = try? JSONDecoder().decode([TodayItem].self, from: Data(contentsOf: url))

    guard let items = todayItems else {
      fatalError("Should be not nil")
    }
    return items
  }
}

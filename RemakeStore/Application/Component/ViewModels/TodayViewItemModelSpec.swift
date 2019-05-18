//
// Created by Scott Moon on 2019-05-18.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import Foundation

import RxSwift
import RxBlocking

@testable import RemakeStore

class TodayItemViewModelSpec: XCTestCase {

  var sut: TodayItemViewModel?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    guard let item = makeTodayItems().first else {
      fatalError("Should be not nil")
    }
    sut = TodayItemViewModel(withTodayItem: item)
    XCTAssertNotNil(sut)
  }

  func test_inject_firstItem_outputs_cellType() {
    guard let item = makeTodayItems().first else {
      fatalError("Should be not nil")
    }
    let expectedCellType = TodayListViewCellType.todayFullBackgroundCell
    sut = TodayItemViewModel(withTodayItem: item)
    XCTAssertNotNil(sut)

    XCTAssertEqual(expectedCellType, sut?.outputs.cellType)
  }

  func test_inject_secondItem_outputs_cellType() {
    let items = makeTodayItems()
    guard let item = items[safe: 1] else {
      fatalError("Should be not nil")
    }
    let expectedCellType = TodayListViewCellType.todayMultipleAppCell
    sut = TodayItemViewModel(withTodayItem: item)
    XCTAssertNotNil(sut)

    XCTAssertEqual(expectedCellType, sut?.outputs.cellType)
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

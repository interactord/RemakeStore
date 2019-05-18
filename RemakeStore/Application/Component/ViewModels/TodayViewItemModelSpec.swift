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
    sut = TodayItemViewModel(withTodayItem: makeTodayItem())
    XCTAssertNotNil(sut)
  }

  func test_outputs() {
    sut = TodayItemViewModel(withTodayItem: makeTodayItem())
    XCTAssertNotNil(sut)

    let output = sut?.outputs
    XCTAssertNotNil(output)
  }

  func makeTodayItem() -> TodayItem {
    let bundleUrl = Bundle.main.url(forResource: "todayItemsDummy", withExtension: "json")
    guard let url = bundleUrl else {
      fatalError("Should be not nil")
    }
    let todayItems = try? JSONDecoder().decode([TodayItem].self, from: Data(contentsOf: url))

    guard let item = todayItems?.first else {
      fatalError("Should be not nil")
    }
    return item
  }
}

//
// Created by Scott Moon on 2019-05-19.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayDetailListViewSpec: XCTestCase {

  var sut: TodayDetailListView?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = TodayDetailListView()
    XCTAssertNotNil(sut)
  }

  func test_numberOfItemsInSection() {
    let expectedCount = 6

    sut = TodayDetailListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else { fatalError("Should be not nil") }

    let resultCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)

    XCTAssertEqual(expectedCount, resultCount)
  }

  func test_cellForItemAt() {
    sut = TodayDetailListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else { fatalError("Should be not nil") }

    let resultFatalCell = dataSource.collectionView(sut, cellForItemAt: [0, 1])
    XCTAssertNotNil(resultFatalCell)

    sut.headerViewModel = makeTodayItemViewModels().first

    let resultTodayFullBackgroundCell = dataSource.collectionView(sut, cellForItemAt: [0, 0])
    XCTAssertNotNil(resultTodayFullBackgroundCell as? TodayFullBackgroundCell)

    sut.headerViewModel = makeTodayItemViewModels()[safe: 1]
    let resultTodayMultipleAppCell = dataSource.collectionView(sut, cellForItemAt: [0, 0])
    XCTAssertNotNil(resultTodayMultipleAppCell as? TodayMultipleAppCell)
  }

  private func makeTodayItemViewModels() -> [TodayItemViewModeling] {
    let bundleUrl = Bundle.main.url(forResource: "todayItemsDummy", withExtension: "json")
    guard
      let url = bundleUrl,
      let todayItems = try? JSONDecoder().decode([TodayItem].self, from: Data(contentsOf: url))
      else {
        fatalError("Should be not nil")
    }

    return todayItems.map { TodayItemViewModel(withTodayItem: $0) }

  }
}

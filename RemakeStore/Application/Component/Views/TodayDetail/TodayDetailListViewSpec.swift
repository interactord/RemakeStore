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
    let expectedNoHeaderViewModelCount = 0
    let expectedTodayMultipleCount = 1
    let expetedTodayTodayFullBackgroundCell = 6

    sut = TodayDetailListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else { fatalError("Should be not nil") }

    let resultNoHeaderViewModelCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)
    XCTAssertEqual(expectedNoHeaderViewModelCount, resultNoHeaderViewModelCount)

    sut.headerViewModel = makeTodayItemViewModels().first
    sut.reloadData()
    let resultTodayTodayFullBackgroundCell = dataSource.collectionView(sut, numberOfItemsInSection: 0)
    XCTAssertEqual(expetedTodayTodayFullBackgroundCell, resultTodayTodayFullBackgroundCell)

    sut.headerViewModel = makeTodayItemViewModels()[safe: 1]
    sut.reloadData()
    let resultTodayMultipleCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)
    XCTAssertEqual(expectedTodayMultipleCount, resultTodayMultipleCount)
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

  func test_delegate_sizeForItemAt() {
    let expectedNoViewModelSize: CGSize = .zero
    let expectedTodayFullBackgroundCellSize: CGSize = .init(width: 0, height: 500)
    let expectedTodayMultipleAppCellSize: CGSize = .init(width: 0, height: UIScreen.main.bounds.height)

    sut = TodayDetailListView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else { fatalError("Should be not nil") }

    let resultNoViewModelSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: [0, 0])
    XCTAssertEqual(expectedNoViewModelSize, resultNoViewModelSize)

    sut.headerViewModel = makeTodayItemViewModels().first
    sut.reloadData()
    let resultTodayFullBackgroundCellSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: [0, 0])
    XCTAssertEqual(expectedTodayFullBackgroundCellSize, resultTodayFullBackgroundCellSize)

    sut.headerViewModel = makeTodayItemViewModels()[safe: 1]
    sut.reloadData()
    let resultTodayMultipleAppCellSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: [0, 0])
    XCTAssertEqual(expectedTodayMultipleAppCellSize, resultTodayMultipleAppCellSize)

    _ = delegate.collectionView?(sut, layout: layout, sizeForItemAt: [0, 1])
    XCTAssertNotNil(sut)
  }

  func test_startAnimation() {
    sut = TodayDetailListView()
    sut?.startAnimation(cell: TodayMultipleAppCell())
    XCTAssertNotNil(sut)
  }

  func test_dismissAnimation() {
    sut = TodayDetailListView()
    sut?.dismissAnimation(cell: TodayMultipleAppCell(), startingFrame: .zero)
    XCTAssertNotNil(sut)
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

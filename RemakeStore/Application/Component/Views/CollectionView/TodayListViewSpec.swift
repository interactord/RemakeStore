//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import UIKit

@testable import RemakeStore

class TodayListViewSpec: XCTestCase {

  var sut: TodayListView?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = TodayListView()

    XCTAssertNotNil(sut)
  }

  func test_noInject_dataSource_numberOfItemsInSection() {
    let expectedCount = 0

    sut = TodayListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    let resultCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)

    XCTAssertEqual(expectedCount, resultCount)
  }

  func test_inject_viewModels_dataSource_numberOfItemsInSection() {
    let viewModels = makeViewModels()
    let expectedCount = viewModels?.count

    sut = TodayListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    sut.todayItemViewModels = viewModels
    let resultCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)

    XCTAssertEqual(expectedCount, resultCount)
  }

  func test_dataSource_cellForItemAt() {
    let viewModels = makeViewModels()

    sut = TodayListView()
    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    sut.todayItemViewModels = viewModels
    let resultBackgroundFullScreenCell = dataSource.collectionView(sut, cellForItemAt: [0, 0])
    let resultTodayMultipleAppCell = dataSource.collectionView(sut, cellForItemAt: [0, 1])

    XCTAssertNotNil(resultBackgroundFullScreenCell as? TodayFullBackgroundCell)
    XCTAssertNotNil(resultTodayMultipleAppCell as? TodayMultipleAppCell)
  }

  func test_dataSource_viewForSupplementaryElementOfKind() {
    let viewModels = makeViewModels()

    sut = TodayListView()
    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    sut.todayItemViewModels = viewModels
    _ = dataSource.collectionView(sut, cellForItemAt: [0, 0])
    let resultHeader = dataSource.collectionView?(sut, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: [0, 3])

    XCTAssertNotNil(resultHeader as? TodayHeader)
  }

  func test_delegate_referenceSizeForHeaderInSection() {
    let expectedHeight: CGFloat = 85

    sut = TodayListView()
    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    let resultSize = delegate.collectionView?(sut, layout: layout, referenceSizeForHeaderInSection: 0)

    XCTAssertEqual(expectedHeight, resultSize?.height)
  }

  func test_delegate_sizeForItemAt() {

    let expectedTodayFullBackgroundCellSize: CGSize = .init(width: -48, height: 466)
    let expectedTodayMultipleAppCellSize: CGSize = .init(width: -48, height: 436)

    sut = TodayListView()
    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    sut.todayItemViewModels = makeViewModels()

    let resultTodayFullBackgroundCellSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: [0, 0])
    XCTAssertEqual(expectedTodayFullBackgroundCellSize, resultTodayFullBackgroundCellSize)

    let resultTodayMultipleCellSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: [0, 1])
    XCTAssertEqual(expectedTodayMultipleAppCellSize, resultTodayMultipleCellSize)
  }

  func test_delegate_minimumLineSpacingForSectionAt() {

    let expectedLineSpacing: CGFloat = 32

    sut = TodayListView()
    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    let resultLineSpacing = delegate.collectionView?(sut, layout: layout, minimumLineSpacingForSectionAt: 0)

    XCTAssertEqual(expectedLineSpacing, resultLineSpacing)
  }

  func test_delegate_insetForSectionAt() {
    let expectedMargin = UIEdgeInsets(top: 10, left: 0, bottom: 32, right: 0)

    sut = TodayListView()
    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    let resultMargin = delegate.collectionView?(sut, layout: layout, insetForSectionAt: 0)

    XCTAssertEqual(expectedMargin, resultMargin)
  }

  private func makeViewModels() -> [TodayItemViewModeling]? {
    let bundleUrl = Bundle.main.url(forResource: "todayItemsDummy", withExtension: "json")
    guard let url = bundleUrl else {
      fatalError("Should be not nil")
    }
    let todayItems = try? JSONDecoder().decode([TodayItem].self, from: Data(contentsOf: url))

    guard let items = todayItems else {
      fatalError("Should be not nil")
    }

    return items.map {
      TodayItemViewModel(withTodayItem: $0)
    }
  }
}

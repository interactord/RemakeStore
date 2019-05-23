//
// Created by Scott Moon on 2019-05-17.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxCocoa
import RxSwift
import RxFlow

@testable import RemakeStore

class TodayMultipleAppListViewSpec: XCTestCase {

  var sut: TodayMultipleAppListView?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = TodayMultipleAppListView()

    XCTAssertNotNil(sut)
  }

  func test_dataSource_numberOfItemsInSection() {
    let expectedCount = 4
    sut = TodayMultipleAppListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else { fatalError("Should be not nil") }

    sut.feedResultViewModels = makeFeedResultViewModels()

    let resultCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)
    XCTAssertEqual(expectedCount, resultCount)
  }

  func test_dataSource_cellForItemAt() {

    sut = TodayMultipleAppListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else { fatalError("Should be not nil") }

    let resultCell = dataSource.collectionView(sut, cellForItemAt: [0, 0])
    XCTAssertNotNil(resultCell as? MultipleAppCell)
  }

  func test_delegate_sizeForItemAt() {

    let expectedCellSize = CGSize(width: 0, height: 68)

    sut = TodayMultipleAppListView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else { fatalError("Should be not nil") }

    let resultCellSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: [0, 0])
    XCTAssertEqual(expectedCellSize, resultCellSize)
  }

  func test_delegate_insetForSectionAt() {
    let expectedPadding: UIEdgeInsets = .zero

    sut = TodayMultipleAppListView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else { fatalError("Should be not nil") }

    let resultPadding = delegate.collectionView?(sut, layout: layout, insetForSectionAt: 0)
    XCTAssertEqual(expectedPadding, resultPadding)
  }

  func test_bind_rootStepper() {
    let expectedRootStepper: PublishRelay<Step> = .init()

    sut = TodayMultipleAppListView()
    sut?.bind(to: expectedRootStepper)
  }

  func makeFeedResultViewModels() -> [FeedResultViewModeling] {
    let bundleUrl = Bundle.main.url(forResource: "todayItemsDummy", withExtension: "json")
    guard let url = bundleUrl else {
      fatalError("Should be not nil")
    }
    let todayItems = try? JSONDecoder().decode([TodayItem].self, from: Data(contentsOf: url))

    guard
      let item = todayItems?[safe: 1],
      let feedResult = item.rss?.feed.results
      else {
        fatalError("Should be not nil")
    }

    return feedResult.map {
      FeedResultViewModel(withFeedResult: $0)
    }
  }

}

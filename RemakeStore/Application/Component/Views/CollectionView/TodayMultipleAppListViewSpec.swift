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

  func test_setMode() {
    sut = TodayMultipleAppListView()
    sut?.viewMode(to: .small)
    sut?.viewMode(to: .fullScreen)

    XCTAssertNotNil(sut)
  }

  func test_dataSource_numberOfItemsInSection() {
    let expectedSmallCount = 4
    let expectedFullScreenCount = 10

    sut = TodayMultipleAppListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else { fatalError("Should be not nil") }

    sut.viewMode(to: .fullScreen)
    let fullScreenResultCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)
    XCTAssertEqual(expectedFullScreenCount, fullScreenResultCount)

    sut.viewMode(to: .small)
    let smallResultCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)
    XCTAssertEqual(expectedSmallCount, smallResultCount)
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

    let expectedSmallCellSize = CGSize(width: 0, height: 68)
    let expectedFullScreenCellSize = CGSize(width: -48, height: 68)

    sut = TodayMultipleAppListView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else { fatalError("Should be not nil") }

    sut.viewMode(to: .small)
    let resultSmallCellSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: [0, 0])
    XCTAssertEqual(expectedSmallCellSize, resultSmallCellSize)

    sut.viewMode(to: .fullScreen)
    let resultFullScreenCellSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: [0, 0])
    XCTAssertEqual(expectedFullScreenCellSize, resultFullScreenCellSize)
  }

  func test_delegate_insetForSectionAt() {
    let expectedSmallPadding: UIEdgeInsets = .zero
    let expectedFullScreenPadding: UIEdgeInsets = .init(top: 12, left: 24, bottom: 12, right: 24)

    sut = TodayMultipleAppListView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else { fatalError("Should be not nil") }

    sut.viewMode(to: .small)
    let resultSmallPadding = delegate.collectionView?(sut, layout: layout, insetForSectionAt: 0)
    XCTAssertEqual(expectedSmallPadding, resultSmallPadding)

    sut.viewMode(to: .fullScreen)
    let resultFullScreenPadding = delegate.collectionView?(sut, layout: layout, insetForSectionAt: 0)
    XCTAssertEqual(expectedFullScreenPadding, resultFullScreenPadding)
  }

  func test_bind_rootStepper() {
    let expectedRootStepper: PublishRelay<Step> = .init()

    sut = TodayMultipleAppListView()
    sut?.bind(to: expectedRootStepper)
  }

}

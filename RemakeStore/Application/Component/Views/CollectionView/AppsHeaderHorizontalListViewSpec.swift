//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class AppsHeaderHorizontalListViewSpec: XCTestCase {
  var sut: AppsHeaderHorizontalListView?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = AppsHeaderHorizontalListView()

    XCTAssertNotNil(sut)
  }

  func test_dataSource_numberOfItemsInSection() {
    sut = AppsHeaderHorizontalListView()
    let expectedCount = 3

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    let resultCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)
    XCTAssertEqual(expectedCount, resultCount)
  }

  func test_dataSource_cellForItemAt() {
    sut = AppsHeaderHorizontalListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    let resultCell = dataSource.collectionView(sut, cellForItemAt: [0, 0])
    XCTAssertNotNil(resultCell as? AppsHeaderCell)
  }

  func test_delegate_sizeForItemAt() {
    let expectedCellSpacing: CGFloat = 48

    sut = AppsHeaderHorizontalListView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    let resultSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: [0, 0])

    XCTAssertEqual(sut.frame.width - expectedCellSpacing, resultSize?.width)
  }

  func test_delegate_insetForSectionAt() {
    let expectedPadding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    sut = AppsHeaderHorizontalListView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    let resultPadding = delegate.collectionView?(sut, layout: layout, insetForSectionAt: 1)

    XCTAssertEqual(expectedPadding, resultPadding)
  }

}

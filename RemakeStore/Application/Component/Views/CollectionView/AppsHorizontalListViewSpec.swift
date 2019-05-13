//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class AppsHorizontalListViewSpec: XCTestCase {
  var sut: AppsHorizontalListView?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = AppsHorizontalListView()
    XCTAssertNotNil(sut)
  }

  func test_contentInset() {
    let expectedInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    sut = AppsHorizontalListView()

    XCTAssertNotNil(sut)
    XCTAssertEqual(expectedInset, sut?.contentInset)
  }

  func test_dataSource_numberOfItemsInSection() {
    let expectedSectionCount = 10
    sut = AppsHorizontalListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
      fatalError("Should be not nil")
    }

    let resultCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)

    XCTAssertEqual(expectedSectionCount, resultCount)
  }

  func test_dataSource_cellForItemAt() {
    sut = AppsHorizontalListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
      fatalError("Should be not nil")
    }

    let resultCell = dataSource.collectionView(sut, cellForItemAt: [0, 0])
    XCTAssertNotNil(resultCell as? AppRowCell)
  }

  func test_delegate_sizeForItemAt() {
    let expactedCellVerticalSpacing: CGFloat = 48
    sut = AppsHorizontalListView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
      fatalError("Should be not nil")
    }

    let resultSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: [0, 0])

    XCTAssertEqual(sut.frame.width - expactedCellVerticalSpacing, resultSize?.width)

  }

  func test_delegate_minimumLineSpacingForSectionAt() {
    let expectedLineSpacing: CGFloat = 10
    sut = AppsHorizontalListView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
      fatalError("Should be not nil")
    }

    let resultMinimumLineSpacing = delegate.collectionView?(sut, layout: layout, minimumLineSpacingForSectionAt: 0)

    XCTAssertEqual(expectedLineSpacing, resultMinimumLineSpacing)
  }

  func test_delegate_insetForSectionAt() {
    let expectedPadding = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)

    sut = AppsHorizontalListView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
      fatalError("Should be not nil")
    }

    let reusultPadding = delegate.collectionView?(sut, layout: layout, insetForSectionAt: 0)
    XCTAssertEqual(expectedPadding, reusultPadding)
  }
}

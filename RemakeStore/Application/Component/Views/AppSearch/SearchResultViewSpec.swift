//
// Created by Scott Moon on 2019-05-13.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class SearchResultViewSpec: XCTestCase {

  var sut: SearchResultView?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = SearchResultView()
    XCTAssertNotNil(sut)
  }

  func test_dataSource_numberOfItemsInSection() {
    sut = SearchResultView()
    let expectedLookupViewModels: [LookupViewModeling] = [LookupViewModel(
        withResult: .init(
          trackId: 123,
          trackName: "test",
          primaryGenreName: "test",
          averageUserRating: 1,
          screenshotUrls: [],
          artworkUrl100: "test",
          formattedPrice: nil,
          description: nil,
          releaseNotes: nil,
          artistName: nil,
          collectionName: nil,
          userRatingCount: nil
        ))]

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    sut.lookupViewModels = expectedLookupViewModels

    XCTAssertEqual(
      expectedLookupViewModels.count,
      dataSource.collectionView(sut, numberOfItemsInSection: sut.lookupViewModels?.count ?? 0)
    )

    sut.lookupViewModels = nil

    XCTAssertEqual(
      0,
      dataSource.collectionView(sut, numberOfItemsInSection: 0)
    )

  }

  func test_dataSource_cellForItemAt() {
    sut = SearchResultView()
    let expectedLookupViewModels: [LookupViewModeling] = [LookupViewModel(
        withResult: .init(
          trackId: 123,
          trackName: "test",
          primaryGenreName: "test",
          averageUserRating: 1,
          screenshotUrls: [],
          artworkUrl100: "test",
          formattedPrice: nil,
          description: nil,
          releaseNotes: nil,
          artistName: nil,
          collectionName: nil,
          userRatingCount: nil
        ))]

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    sut.lookupViewModels = expectedLookupViewModels

    let cell = dataSource.collectionView(sut, cellForItemAt: .init(row: 0, section: 0))
    XCTAssertNotNil(cell as? SearchResultCell)
  }

  func test_delegate_sizeForItemAt() {
    let expectedHeight: CGFloat = 300

    sut = SearchResultView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    let size = delegate.collectionView?(sut, layout: layout, sizeForItemAt: .init(row: 0, section: 0))

    XCTAssertEqual(expectedHeight, size?.height)
  }

  func test_delegate_minimumLineSpacingForSectionAt() {
    let expectedCellHeightSpacing: CGFloat = 30

    sut = SearchResultView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    let resultCellHeightSpacing = delegate.collectionView?(sut, layout: layout, minimumLineSpacingForSectionAt: 0)

    XCTAssertEqual(expectedCellHeightSpacing, resultCellHeightSpacing)
  }
}

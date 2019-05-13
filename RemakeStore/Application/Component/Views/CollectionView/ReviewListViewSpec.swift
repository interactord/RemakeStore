//
// Created by Scott Moon on 2019-05-13.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import UIKit

@testable import RemakeStore

class ReviewListViewSpec: XCTestCase {

  var sut: ReviewListView?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = ReviewListView()
    XCTAssertNotNil(sut)
  }

  func test_dataSource_numberOfItemsInSection() {
    let testLabel = Label(label: "test")
    let ratingLabel = Label(label: "1")
    let entry = Entry(
      author: Author(name: testLabel), title: testLabel, content: testLabel, rating: ratingLabel
    )
    let expectedViewModels: [ReviewsEntryViewModeling] = [
      ReviewsEntryViewModel(withEntry: entry),
      ReviewsEntryViewModel(withEntry: entry)
    ]

    sut = ReviewListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    let noInjectedViewModelCellCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)
    XCTAssertEqual(0, noInjectedViewModelCellCount)

    sut.reviewEntryViewModels = expectedViewModels
    let injectedViewModelCellCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)
    XCTAssertEqual(expectedViewModels.count, injectedViewModelCellCount)
  }
}

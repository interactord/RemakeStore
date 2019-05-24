//
// Created by Scott Moon on 2019-05-13.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import UIKit
import RxSwift
import RxCocoa
import RxTest
@testable import RemakeStore

class AppDetailResultViewSpec: XCTestCase {

  var sut: AppDetailResultView?
  var disposeBag = DisposeBag()

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
    disposeBag = DisposeBag()
  }

  func test_init() {
    sut = AppDetailResultView()
    XCTAssertNotNil(sut)
  }

  func test_dataSource_numberOfItemsInSection() {
    sut = AppDetailResultView()
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

  func test_dataSource_cellForItemAt_lookupCell() {

    let viewModel: LookupViewModeling = LookupViewModel(
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
        collectionName: nil
      ))

    sut = AppDetailResultView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    let resultNoViewModelLookupCell = dataSource.collectionView(sut, cellForItemAt: .init(row: 0, section: 0))
    XCTAssertNotNil(resultNoViewModelLookupCell as? LookupCell)

    sut.lookupViewModel = viewModel
    let resultViewModelLookupCell = dataSource.collectionView(sut, cellForItemAt: .init(row: 0, section: 0))
    XCTAssertNotNil(resultViewModelLookupCell as? LookupCell)
  }

  func test_dataSource_cellForItemAt_previewCell() {

    let viewModels: [ScreenshotViewModeling] = [
      ScreenshotViewModel(withScreenshot: "test.com")
    ]

    sut = AppDetailResultView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    let resultNoViewModelPreviewCell = dataSource.collectionView(sut, cellForItemAt: .init(row: 1, section: 0))
    XCTAssertNotNil(resultNoViewModelPreviewCell as? PreviewCell)

    sut.screenshotViewModels = viewModels
    let resultViewModelPreviewCell = dataSource.collectionView(sut, cellForItemAt: .init(row: 1, section: 0))
    XCTAssertNotNil(resultViewModelPreviewCell as? PreviewCell)
  }

  func test_dataSource_cellForItemAt_reviewRowCell() {
    let testLabel = Label(label: "test")
    let ratingLabel = Label(label: "1")
    let entry = Entry(
      author: Author(name: testLabel), title: testLabel, content: testLabel, rating: ratingLabel
    )

    let viewModels: [ReviewsEntryViewModeling] = [
      ReviewsEntryViewModel(withEntry: entry)
    ]

    sut = AppDetailResultView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    let resultNoViewModelReviewRowCell = dataSource.collectionView(sut, cellForItemAt: .init(row: 2, section: 0))
    XCTAssertNotNil(resultNoViewModelReviewRowCell as? ReviewRowCell)

    sut.reviewEntryViewModels = viewModels
    let resultViewModelReviewRowCell = dataSource.collectionView(sut, cellForItemAt: .init(row: 2, section: 0))
    XCTAssertNotNil(resultViewModelReviewRowCell as? ReviewRowCell)
  }

  func test_dataSource_sizeForItemAt() {
    let expectedLookupCellHeight: CGFloat = 256
    let expectedPreviewCellHeight: CGFloat = 500
    let expectedReviewRowCellHeight: CGFloat = 280

    sut = AppDetailResultView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    let resultLoookupCellSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: .init(row: 0, section: 0)) ?? .zero
    XCTAssertLessThanOrEqual(expectedLookupCellHeight, resultLoookupCellSize.height)

    let resultPreviewCellSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: .init(row: 1, section: 0)) ?? .zero
    XCTAssertLessThanOrEqual(expectedPreviewCellHeight, resultPreviewCellSize.height)

    let resultReviewRowCellSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: .init(row: 2, section: 0)) ?? .zero
    XCTAssertLessThanOrEqual(expectedReviewRowCellHeight, resultReviewRowCellSize.height)
  }

  func test_dataSource_sizeForItemAt_dynamicSize() {
    let expectedLookupCellHeight: CGFloat = 1_000
    sut = AppDetailResultView()

    let viewModel: LookupViewModeling = LookupViewModel(
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
        collectionName: nil
      ))

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    sut.lookupViewModel = viewModel
    let resultLoookupCellSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: .init(row: 0, section: 0))
    XCTAssertTrue(expectedLookupCellHeight >= resultLoookupCellSize?.height ?? 1_001)

  }

  func test_dataSource_insetForSectionAt() {
    let expectedPadding: UIEdgeInsets = .init(top: 0, left: 0, bottom: 10, right: 0)

    sut = AppDetailResultView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    let resultPadding = delegate.collectionView?(sut, layout: layout, insetForSectionAt: 0)
    XCTAssertEqual(expectedPadding, resultPadding)
  }
}

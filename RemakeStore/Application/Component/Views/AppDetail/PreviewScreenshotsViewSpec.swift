//
// Created by Scott Moon on 2019-05-13.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import UIKit

@testable import RemakeStore

class PreviewScreenshotsViewSpec: XCTestCase {

  var sut: PreviewScreenshotsView?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = PreviewScreenshotsView()
    XCTAssertNotNil(sut)
  }

  func test_dataSource_numberOfItemsInSection() {
    let expectedViewModels: [ScreenshotViewModeling] = [
      ScreenshotViewModel(withScreenshot: "test.com"),
      ScreenshotViewModel(withScreenshot: "test.com"),
      ScreenshotViewModel(withScreenshot: "test.com")
    ]

    sut = PreviewScreenshotsView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    let noInjectedViewModelResultCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)
    XCTAssertEqual(0, noInjectedViewModelResultCount)

    sut.screenshotViewModels = expectedViewModels
    let injectedVIewModelResultCount = dataSource.collectionView(sut, numberOfItemsInSection: 0)
    XCTAssertEqual(expectedViewModels.count, injectedVIewModelResultCount)
  }

  func test_dataSource_cellForItemAt() {
    let viewModels: [ScreenshotViewModeling] = [
      ScreenshotViewModel(withScreenshot: "test.com")
    ]

    sut = PreviewScreenshotsView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    let noInjectedViewModelScreenshotCell = dataSource.collectionView(sut, cellForItemAt: [0, 0])
    XCTAssertNotNil(noInjectedViewModelScreenshotCell as? ScreenshotCell)

    sut.screenshotViewModels = viewModels
    let injectedViewModelScreenshotCell = dataSource.collectionView(sut, cellForItemAt: [0, 0])
    XCTAssertNotNil(injectedViewModelScreenshotCell as? ScreenshotCell)
  }

  func test_delegate_sizeForItemAt() {

    let expectedCellSizeWidth: CGFloat = 250
    sut = PreviewScreenshotsView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    let cellSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: [0, 0])
    XCTAssertEqual(expectedCellSizeWidth, cellSize?.width)

  }

  func test_delegate_minimumLineSpacingForSectionAt() {

    let expectedCellMinimumSpacing: CGFloat = 15
    sut = PreviewScreenshotsView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    let cellSpacing = delegate.collectionView?(sut, layout: layout, minimumLineSpacingForSectionAt: 0)
    XCTAssertEqual(expectedCellMinimumSpacing, cellSpacing)

  }
}

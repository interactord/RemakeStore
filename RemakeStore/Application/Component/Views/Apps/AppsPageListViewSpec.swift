//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxCocoa
import RxFlow

@testable import RemakeStore

class AppsPageListViewSpec: XCTestCase {
  var sut: AppsPageListView?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = AppsPageListView()
    XCTAssertNotNil(sut)
  }

  func test_dataSource_numberOfItemsInSection() {
    let expectedSectionCount = 0
    sut = AppsPageListView()

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
    sut = AppsPageListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    let resultCell = dataSource.collectionView(sut, cellForItemAt: [0, 0])
    XCTAssertNotNil(resultCell as? AppsGroupCell)
  }

  func test_dataSource_inject_viewModel_rootStepper_cellForItemAt() {
    let rootStepper = PublishRelay<Step>()

    sut = AppsPageListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    sut.bind(to: rootStepper)
    sut.feedViewModels = makeFeedViewModels()

    let resultAppGroupCell = dataSource.collectionView(sut, cellForItemAt: [0, 0])
    XCTAssertNotNil(resultAppGroupCell as? AppsGroupCell)
  }

  func test_dataSource_inject_viewModel_viewForSupplementaryElementOfKind() {
    sut = AppsPageListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    sut.socialAppViewModels = makeSocialAppViewModels()

    dataSource.collectionView(sut, cellForItemAt: [1, 3])
    let resultHeaderView = dataSource.collectionView?(sut, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: .init(row: 0, section: 0))
    XCTAssertNotNil(resultHeaderView as? AppsPageHeader)
  }

  func test_dataSource_viewForSupplementaryElementOfKind() {
    sut = AppsPageListView()

    guard
      let sut = sut,
      let dataSource = sut.dataSource
      else {
        fatalError("Should be not nil")
    }

    dataSource.collectionView(sut, cellForItemAt: [1, 3])
    let resultHeaderView = dataSource.collectionView?(sut, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: .init(row: 0, section: 0))
    XCTAssertNotNil(resultHeaderView as? AppsPageHeader)
  }

  func test_delegate_sizeForItemAt() {
    let expectedHegith: CGFloat = 300

    sut = AppsPageListView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    let resultSize = delegate.collectionView?(sut, layout: layout, sizeForItemAt: [0, 0])

    XCTAssertEqual(expectedHegith, resultSize?.height)
  }

  func test_delegate_referenceSizeForHeaderInSection() {
    let expectedHegith: CGFloat = 300

    sut = AppsPageListView()

    guard
      let sut = sut,
      let delegate = sut.delegate as? UICollectionViewDelegateFlowLayout,
      let layout = sut.collectionViewLayout as? UICollectionViewFlowLayout
      else {
        fatalError("Should be not nil")
    }

    let resultSize = delegate.collectionView?(sut, layout: layout, referenceSizeForHeaderInSection: 1)
    XCTAssertEqual(expectedHegith, resultSize?.height)
  }

  func test_delegate_insetForSectionAt() {
    let expectedPadding = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)

    sut = AppsPageListView()

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

  func makeFeedViewModels() -> [FeedViewModel] {
    return [
      FeedViewModel(withFeed: Feed(
        title: "test Title",
        results: [
          FeedResult(id: "123", name: "test name", artistName: "test artistName", artworkUrl100: "test-image.com")
        ]))
    ]
  }

  func makeSocialAppViewModels() -> [SocialAppViewModel] {
    return [
      SocialAppViewModel(withSocialApp: SocialApp(
        id: "123", name: "test name", imageUrl: "test-image.com", tagline: "test tag"))
    ]
  }
}

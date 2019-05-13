//
// Created by Scott Moon on 2019-05-12.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class SearchResultCellSpec: XCTestCase {

  var sut: SearchResultCell?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = SearchResultCell(frame: .zero)
    XCTAssertNotNil(sut)
  }

  func test_prepareForReuse() {
    sut = SearchResultCell(frame: .zero)
    sut?.prepareForReuse()
    XCTAssertNotNil(sut)
  }

  func test_bind() {

    let lookup = Lookup.Information(
      trackId: 123,
      trackName: "test",
      primaryGenreName: "test",
      averageUserRating: 1,
      screenshotUrls: [
        "test.com",
        "test.com",
        "test.com"
      ],
      artworkUrl100: "test",
      formattedPrice: nil,
      description: nil,
      releaseNotes: nil,
      artistName: nil,
      collectionName: nil
    )

    let viewModel: LookupViewModeling = LookupViewModel(withResult: lookup)

    sut = SearchResultCell(frame: .zero)
    sut?.bind(to: viewModel)
    sut?.updateConstraints()
    XCTAssertNotNil(sut)

  }
}

//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift
import RxBlocking

@testable import RemakeStore

class LookupViewModelSpec: XCTestCase {

  var sut: LookupViewModel?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_output_no_nil() {
    let expectedName = "testTrack"
    let expectedReleaseNote = "test release"
    let expectedAppIconImageUrlPath = "testImage.com"
    let expectedCategory = "testcategory"
    let expectedRating: Float = 1.0
    let expectedPriceFormat = "Free"
    let exptectScreenshotUrls = ["testscreenshot.com"]
    sut = LookupViewModel(withResult: makeInformation())

    XCTAssertEqual(expectedName, try sut?.outputs.name.toBlocking().first())
    XCTAssertEqual(expectedReleaseNote, try sut?.outputs.releaseNote.toBlocking().first())
    XCTAssertEqual(expectedAppIconImageUrlPath, try sut?.outputs.appIconImageUrlPath.toBlocking().first())
    XCTAssertEqual(expectedCategory, try sut?.outputs.category.toBlocking().first())
    XCTAssertEqual(expectedPriceFormat, try sut?.outputs.priceFormat.toBlocking().first())
    XCTAssertEqual(expectedRating, try sut?.outputs.rating.toBlocking().first())
    XCTAssertEqual(exptectScreenshotUrls, try sut?.outputs.screenshotUrlPaths.toBlocking().first())
  }

  func test_output_option_nil() {
    let expectedReleaseNote = ""
    let exptectedRating: Float = 0.0
    let expectedPriceFormat = ""

    sut = LookupViewModel(withResult: makeOptionalInformation())

    XCTAssertEqual(expectedReleaseNote, try sut?.outputs.releaseNote.toBlocking().first())
    XCTAssertEqual(exptectedRating, try sut?.outputs.rating.toBlocking().first())
    XCTAssertEqual(expectedPriceFormat, try sut?.outputs.priceFormat.toBlocking().first())
  }

  func makeInformation() -> LookupInformation {
    return LookupInformation(
      trackId: 123,
      trackName: "testTrack",
      primaryGenreName: "testcategory",
      averageUserRating: 1,
      screenshotUrls: ["testscreenshot.com"],
      artworkUrl100: "testImage.com",
      formattedPrice: "Free",
      description: "test description",
      releaseNotes: "test release",
      artistName: "test",
      collectionName: "testCollection",
      userRatingCount: 2_124
    )
  }

  func makeOptionalInformation() -> LookupInformation {
    return LookupInformation(
      trackId: 123,
      trackName: "testTrack",
      primaryGenreName: "testcategory",
      averageUserRating: nil,
      screenshotUrls: nil,
      artworkUrl100: "testImage.com",
      formattedPrice: nil,
      description: nil,
      releaseNotes: nil,
      artistName: nil,
      collectionName: nil,
      userRatingCount: nil
    )
  }
}

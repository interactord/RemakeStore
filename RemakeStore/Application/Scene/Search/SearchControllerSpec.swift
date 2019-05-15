//
// Created by Scott Moon on 2019-05-12.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import SCServiceKit
@testable import RemakeStore

class SearchControllerSpec: XCTestCase {
  var sut: SearchController?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_bind() {
    sut = SearchController()
    let viewModel = makeViewModel()
    sut?.viewModel = viewModel

    sut?.bind(to: viewModel)

    XCTAssertNotNil(sut)
  }

  func test_setupConstraints() {
    let viewModel = makeViewModel()

    sut = SearchController()
    sut?.viewModel = viewModel

    sut?.updateViewConstraints()
    XCTAssertNotNil(sut)
  }

  func test_searchResultView_itemSelected() {
    let viewModel = makeViewModel()
    sut = SearchController()

    guard let sut = sut else {
      fatalError("Should be not nil")
    }

    let lookupViewModels: [LookupViewModeling] = [LookupViewModel(
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
        ))]
    let resultView = sut.searchResultView
    resultView.lookupViewModels = lookupViewModels

    // swiftlint:disable force_unwrapping
    sut.viewModel = viewModel
    sut.bind(to: viewModel)

    let indexPath = IndexPath(row: 0, section: 0)
    resultView.delegate!.collectionView!(resultView, didSelectItemAt: indexPath)
    // swiftlint:enable force_unwrapping

  }

  func makeViewModel() -> SearchViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service
    let baseUrl = "http://localhost:7000"
    let repository = ITunesRepository(httpClient: service.httpClient, baseUrl: baseUrl)
    return SearchViewModel(
      with: service, iTunesRepository: repository
    )
  }
}

//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift
import SCServiceKit
import RxBlocking

@testable import RemakeStore

class SearchViewModelSpec: XCTestCase {

  var sut: SearchViewModel?
  let stubServer = StubServer()

  override func setUp() {
    super.setUp()
    stubServer.setup()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
    stubServer.tearDown()
  }

  func test_output_searchViewModels_manyViewModels() {

    let expectedCount = 3

    sut = makeSUT()
    sut?.inputs.searchText.onNext("facebook")

    XCTAssertEqual(expectedCount, try sut?.outputs.searchViewModels.toBlocking().first()?.count)

  }

  func makeSUT() -> SearchViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service
    let baseUrl = "http://localhost:7000"
    let repository = ITunesRepository(httpClient: service.httpClient, baseUrl: baseUrl)
    return SearchViewModel(
      with: service, iTunesRepository: repository
    )
  }

}

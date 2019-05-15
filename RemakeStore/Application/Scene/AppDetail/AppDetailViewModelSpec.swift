//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift
import RxBlocking
import SCServiceKit

@testable import RemakeStore

class AppDetailViewModelSpec: XCTestCase {

  let stubServer = StubServer()
  var sut: AppDetailViewModel?

  override func setUp() {
    super.setUp()
    stubServer.setup()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
    stubServer.tearDown()
  }

  func test_init() {
    sut = makeSUT()
  }

  func test_output_lookupViewModel() {

    sut = makeSUT()
    sut?.inputs.appId.onNext(1_209_489_068)

    XCTAssertNoThrow(try sut?.outputs.lookupViewModel.toBlocking().first())
  }

  func test_output_reviewsEntryModels_reviewsEntryModels() {

    sut = makeSUT()

    sut?.inputs.appId.onNext(1_209_489_068)

    XCTAssertNoThrow(try sut?.outputs.reviewsEntryModels.toBlocking().first())
    XCTAssertNoThrow(try sut?.outputs.screenshotViewModels.toBlocking().first())
  }

  func makeSUT() -> AppDetailViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service
    let baseUrl = "http://localhost:7000"
    let repository = ITunesRepository(
      httpClient: service.httpClient,
      baseUrl: baseUrl
    )

    return AppDetailViewModel(
      with: service,
      repository: repository
    )
  }

}

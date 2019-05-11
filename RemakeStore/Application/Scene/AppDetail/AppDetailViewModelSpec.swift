//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift
import SCServiceKit

@testable import RemakeStore

class AppDetailViewModelSpec: XCTestCase {

  let stubServer = StubServer()
  var sut: AppDetailViewModel?
  var disposeBag = DisposeBag()

  override func setUp() {
    super.setUp()
    stubServer.setup()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
    disposeBag = DisposeBag()
    stubServer.tearDown()
  }

  func test_init() {
    sut = makeSUT()
  }

  func test_output_lookupViewModel() {
    let expectedCallEvent = XCTestExpectation(description: "called event")

    sut = makeSUT()

    sut?.inputs.appId.onNext(1_209_489_068)
    sut?.outputs.lookupViewModel
      .subscribe(onNext: { viewModel in
        XCTAssertNotNil(viewModel)
        expectedCallEvent.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectedCallEvent], timeout: 5.0)
  }

  func test_output_reviewsEntryModels_reviewsEntryModels() {
    let expectedRevicesCallEvent = XCTestExpectation(description: "called event reviews")
    let expectedScreenshotsCallEvent = XCTestExpectation(description: "called event screenshot")

    sut = makeSUT()

    sut?.inputs.appId.onNext(1_209_489_068)
    sut?.outputs.reviewsEntryModels
      .subscribe(onNext: { viewModel in
        XCTAssertNotNil(viewModel)
        expectedRevicesCallEvent.fulfill()
      }).disposed(by: disposeBag)

    sut?.outputs.screenshotViewModels
      .subscribe(onNext: { viewModel in
        XCTAssertNotNil(viewModel)
        expectedScreenshotsCallEvent.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectedRevicesCallEvent, expectedScreenshotsCallEvent], timeout: 5.0)
  }

  func makeSUT() -> AppDetailViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service

    let lookupRepository = AnyRepository<Lookup>(base: LookupRepository(
      httpClient: service.httpClient
    ))

    let reviewsRepository = AnyRepository<Reviews>(
      base: ReviewsRepositoryMock(
        httpClient: service.httpClient
      )
    )

    return AppDetailViewModel(
      with: service,
      lookupRepository: lookupRepository,
      reviewsRepository: reviewsRepository
    )
  }

}

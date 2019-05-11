//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift
import SCServiceKit
@testable import RemakeStore

class SearchViewModelSpec: XCTestCase {

  var sut: SearchViewModel?
  var disposeBag = DisposeBag()

  let stubServer = StubServer()

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

  func test_output_searchViewModels_manyViewModels() {
    let expectedCallEvent = XCTestExpectation(description: "event called")
    let expectedCount = 3

    sut = makeSUT()
    sut?.inputs.searchText.onNext("facebook")

    sut?.outputs.searchViewModels
      .subscribe(onNext: { viewModels in
        XCTAssertEqual(expectedCount, viewModels.count)
        expectedCallEvent.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectedCallEvent], timeout: 5.0)

  }

  func makeSUT() -> SearchViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service
    let searchRepository = AnyRepository<AppResult>(
      base: SearchRepositoryMock(
        httpClient: service.httpClient
      )
    )
    return SearchViewModel(with: service, searchRepository: searchRepository)
  }

}

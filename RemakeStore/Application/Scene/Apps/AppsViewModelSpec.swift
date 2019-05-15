//
// Created by Scott Moon on 2019-05-15.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift
import RxBlocking

@testable import RemakeStore

class AppsViewModelSpec: XCTestCase {
  var sut: AppsViewModel!
  let server = StubServer()
  var disposbag = DisposeBag()

  override func setUp() {
    super.setUp()
    server.setup()
    disposbag = DisposeBag()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
    server.tearDown()
  }

  func test_init() {
    sut = makeSUT()

    XCTAssertNotNil(sut)
  }

  func test_fetchApps() {
    sut = makeSUT()
    sut.inputs.fetchApps.onNext(Void())

    XCTAssertNoThrow(try sut.outputs.appsGroups.toBlocking().first())
    XCTAssertNoThrow(try sut.outputs.socialAppViewModels.toBlocking().first())

  }

  func makeSUT() -> AppsViewModel {

    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service
    let rssRepository = RssRepository(httpClient: service.httpClient, baseURL: "http://localhost:7000")
    let interactordRepository = InteractordRepository(httpClient: service.httpClient, baseUrl: "http://localhost:7000")

    return AppsViewModel(
      with: service, rssRepository: rssRepository, interactordRepository: interactordRepository
    )
  }
}

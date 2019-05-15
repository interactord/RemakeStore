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
    let expectedCallEvent = XCTestExpectation(description: "called event")

    sut = makeSUT()

    sut.inputs.fetchApps.onNext(Void())
    sut.outputs.appsGroups
      .subscribe(onNext: { apps in
        XCTAssertNotNil(apps)
        expectedCallEvent.fulfill()
      }).disposed(by: disposbag)

    wait(for: [expectedCallEvent], timeout: 10.0)

  }

  func makeSUT() -> AppsViewModel {

    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service
    let rssRepository = RssRepository(httpClient: service.httpClient, baseURL: "http://localhost:7000")

    return AppsViewModel(with: service, rssRepository: rssRepository)
  }
}

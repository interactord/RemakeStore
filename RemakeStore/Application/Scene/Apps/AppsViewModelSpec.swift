//
// Created by Scott Moon on 2019-05-15.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import RxSwift
import RxTest

@testable import RemakeStore

class AppsViewModelSpec: XCTestCase {
  var sut: AppsViewModel!
  var disposbag = DisposeBag()
  var scheduler = TestScheduler(initialClock: 0)

  override func setUp() {
    super.setUp()
    disposbag = DisposeBag()
    scheduler = TestScheduler(initialClock: 0)
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = makeSUT()

    XCTAssertNotNil(sut)
  }

  func test_fetchApps() {

  }

  func makeSUT() -> AppsViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service
    let rssRepository = RssRepository(httpClient: service.httpClient, baseURL: "http://localHost:7000")

    return AppsViewModel(with: service, rssRepository: rssRepository)
  }
}

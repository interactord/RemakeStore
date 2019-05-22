//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayControllerSpec: XCTestCase {

  var sut: TodayController?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = TodayController()
    XCTAssertNotNil(sut)
  }

  func test_viewDidLoad() {
    sut = TodayController()
    sut?.viewDidLoad()
    XCTAssertNotNil(sut)
  }

  func test_setupConstraints() {
    sut = TodayController()
    sut?.setupConstraints()
    XCTAssertNotNil(sut)
  }

  func test_bind() {
    let viewModel = makeViewModel()
    sut = TodayController()
    sut?.viewModel = viewModel
    sut?.bind(to: viewModel)
  }

  func test_setupFullscreenView() {

    let tagetFullScreenController: FullScreenViewControllerAnimatable = TodayDetailController()
    let info = FullScreenAnimatedInfo(
      todayItemViewModel: makeTodayItemViewModel(),
      startingFrame: .init(x: 0, y: 0, width: 0, height: 0)
    )
    sut = TodayController()
    sut?.setupFullscreenView(tagetFullScreenController, info: info)

    sut?.targetFullScreenController = tagetFullScreenController
    sut?.setupFullscreenView(tagetFullScreenController, info: info)

    XCTAssertNotNil(sut)
  }

  func test_startFullScreenAnimation() {
    sut = TodayController()
    sut?.targetFullScreenController = TodayDetailController()

    sut?.startFullScreenAnimation()

    XCTAssertNotNil(sut)
  }

  func test_dismissFullScreenAnimation() {
    sut = TodayController()
    sut?.dismissFullScreenAnimation()
//
    XCTAssertNotNil(sut)
  }

  func test_prefersStatusBarHidden() {
    sut = TodayController()

    sut?.fullScreenStatus = .fullScreen
    XCTAssertTrue(sut?.prefersStatusBarHidden ?? false)

    sut?.fullScreenStatus = .thumbnail
    XCTAssertFalse(sut?.prefersStatusBarHidden ?? true)
  }

  func makeViewModel() -> TodayViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service
    let rssRepository = RssRepository(httpClient: service.httpClient, baseURL: "http://localhost:7000")
    let interactordRepository = InteractordRepository(httpClient: service.httpClient, baseUrl: "http://localhost:7000")

    return TodayViewModel(
      with: service,
      interactordRepository: interactordRepository,
      rssRepository: rssRepository
    )
  }

  private func makeTodayItemViewModel() -> TodayItemViewModeling {
    let bundleUrl = Bundle.main.url(forResource: "todayItemsDummy", withExtension: "json")
    guard
      let url = bundleUrl,
      let todayItems = try? JSONDecoder().decode([TodayItem].self, from: Data(contentsOf: url)),
      let item = todayItems.first
      else {
        fatalError("Should be not nil")
    }

    return TodayItemViewModel(withTodayItem: item) }
}

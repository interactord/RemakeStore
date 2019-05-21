//
// Created by Scott Moon on 2019-05-19.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayDetailControllerSpec: XCTestCase {

  var sut: TodayDetailController?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_init() {
    sut = TodayDetailController()
    sut?.viewDidLoad()
    sut?.setupConstraints()

    XCTAssertNotNil(sut)
  }

  func test_bind() {
    let viewModel = makeViewModel()
    sut = TodayDetailController()
    sut?.bind(to: viewModel)

    XCTAssertNotNil(sut)
  }

  func test_setupFullScreenLayout() {
    sut = TodayDetailController()
    sut?.setupFullScreenLayout(startingFrame: .zero)
  }

  func test_noInject_startFullScreenAnimation() {
    sut = TodayDetailController()
    sut?.startFullScreenAnimation()

    XCTAssertNil(sut?.view.superview)
  }

  func test_inject_startFullScreenAnimation() {

    let viewController = UIViewController()
    sut = TodayDetailController()

    viewController.view.addSubview(sut?.view ?? UIView())
    sut?.startFullScreenAnimation()

    XCTAssertNotNil(sut?.view.superview)
  }

  func test_noInject_dismissFullScreenAnimation() {
    sut = TodayDetailController()
    sut?.dismissFullScreenAnimation()

    XCTAssertNotNil(sut)
  }

  func test_inject_startingFrame_dismissFullScreenAnimation() {
    let startingFrame: CGRect = .zero

    sut = TodayDetailController()
    sut?.startingFrame = startingFrame

    sut?.dismissFullScreenAnimation()
    XCTAssertNotNil(sut)
  }

  func test_startDragGesture() {
    sut = TodayDetailController()
    sut?.startDragGesture()
    XCTAssertNotNil(sut)
  }

  func makeViewModel() -> TodayDetailViewModel {
    var serviceDIContainer = ServiceDIContainer()
    let service = serviceDIContainer.service
    guard let todayItemViewModel = makeTodayItemViewModels()?.first else {
      fatalError("Should be not nil")
    }

    return TodayDetailViewModel(with: service, todayItemViewModel: todayItemViewModel)
  }

  private func makeTodayItemViewModels() -> [TodayItemViewModeling]? {
    let bundleUrl = Bundle.main.url(forResource: "todayItemsDummy", withExtension: "json")
    guard
      let url = bundleUrl,
      let todayItems = try? JSONDecoder().decode([TodayItem].self, from: Data(contentsOf: url))
      else {
        fatalError("Should be not nil")
    }

    return todayItems.map {
      TodayItemViewModel(withTodayItem: $0)
    }
  }
}

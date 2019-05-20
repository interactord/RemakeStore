//
//  TodayFlowSpec.swift
//  RemakeStoreTests
//
//  Created by Scott Moon on 21/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class TodayFlowSpec: XCTestCase {
  var sut: TodayFlow?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func test_init() {
    let service = makeService()
    sut = TodayFlow(with: service)

    XCTAssertNotNil(sut)
  }

  func test_navigate() {
    let service = makeService()
    let fullScreenAnimatedInfo = FullScreenAnimatedInfo(
      todayItemViewModel: makeTodayItemViewModel(),
      startingFrame: .zero
    )

    sut = TodayFlow(with: service)

    XCTAssertNotNil(sut?.navigate(to: AppStep.dashboardIsComplete))
    XCTAssertNotNil(sut?.navigate(to: AppStep.todayDetailIsRequired(fullScreenAnimatedInfo: fullScreenAnimatedInfo)))
    XCTAssertNotNil(sut?.navigate(to: AppStep.appDetailIsComplete))
  }

  func test_noSubViews_navigateToTodayDetailScreen() {
    let service = makeService()
    let fullScreenAnimatedInfo = FullScreenAnimatedInfo(
      todayItemViewModel: makeTodayItemViewModel(),
      startingFrame: .zero
    )

    sut = TodayFlow(with: service)

    XCTAssertNotNil(sut?.navigate(to: AppStep.todayDetailIsRequired(fullScreenAnimatedInfo: fullScreenAnimatedInfo)))
  }

  func test_inject_subView_navigateToTodayDetailScreen() {
    let service = makeService()
    let fullScreenAnimatedInfo = FullScreenAnimatedInfo(
      todayItemViewModel: makeTodayItemViewModel(),
      startingFrame: .zero
    )

    sut = TodayFlow(with: service)

    sut?.rootViewController.setViewControllers([TodayController()], animated: false)
    XCTAssertNotNil(sut?.navigate(to: AppStep.todayDetailIsRequired(fullScreenAnimatedInfo: fullScreenAnimatedInfo)))
  }

  func makeService() -> Service {
    var serviceDIContainer = ServiceDIContainer()
    return serviceDIContainer.service
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

    return TodayItemViewModel(withTodayItem: item)
  }
}

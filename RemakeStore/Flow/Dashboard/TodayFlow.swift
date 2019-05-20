//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow

class TodayFlow: BaseFlow {

  // MARK: - Private

  private(set) lazy var rootViewController: UINavigationController = {
    var container = TodayDIContainer(with: service)
    return container.navigationController
  }()

  // MARK: - Protocol Variables

  let service: Service

  var root: Presentable {
    return rootViewController
  }

  // MARK: - Initializing

  required init(with service: Service) {
    self.service = service
  }

  // MARK: - functions for protocol

  internal func navigate(to step: AppStep) -> FlowContributors {
    switch step {
    case .dashboardIsComplete:
      return navigateToTodayScreen()
    case .todayDetailIsRequired(let fullScreenAnimatedInfo):
      return navigateToTodayDetailScreen(fullScreenAnimatedInfo)
    default:
      return .none
    }
  }
}

extension TodayFlow {

  private func navigateToTodayScreen() -> FlowContributors {
    var container = TodayDIContainer(with: service)
    let controller = container.getController()
    rootViewController.setViewControllers([controller], animated: false)
    rootViewController.isNavigationBarHidden = true

    let contributor = FlowContributor.contribute(
      withNextPresentable: controller,
      withNextStepper: controller
    )

    return .one(flowContributor: contributor)
  }

  private func navigateToTodayDetailScreen(_ fullScreenAnimatedInfo: FullScreenAnimatedInfo) -> FlowContributors {
    let info = fullScreenAnimatedInfo
    var container = TodayDetailDIContainer(with: service, todayItemViewModel: info.todayItemViewModel)
    let controller = container.getController()

    guard
      let viewController = rootViewController.viewControllers.first,
      let parentController = viewController as? FullScreenAnimatable
      else { return .none }

    parentController.setupFullscreenView(controller, info: fullScreenAnimatedInfo)
    parentController.startFullScreenAnimation()

    let contributor = FlowContributor.contribute(
      withNextPresentable: controller,
      withNextStepper: controller
    )

    return .one(flowContributor: contributor)
  }
}

//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow

class SearchFlow: BaseFlow {

  // MARK: - Private

  let service: Service

  lazy var rootViewController: UINavigationController = {
    var container = SearchDIContainer(with: service)
    return container.navigationController
  }()

  required init(with service: Service) {
    self.service = service
  }

  // MARK: - Protocol Variables
  var root: Presentable {
    return rootViewController
  }

  // MARK: - functions for protocol
  internal func navigate(to step: AppStep) -> FlowContributors {

    switch step {
    case .dashboardIsComplete:
      return navigateToSearchScreen()
    case .detailAppIsRequired(let appId):
      return navigateToDetailApp(with: appId)
    case .detailAppIsComplete:
      return dismissDetailAppController()
    default:
      return .none
    }
  }

  private func navigateToSearchScreen() -> FlowContributors {
    var container = SearchDIContainer(with: service)
    let controller = container.getController()
    rootViewController.setViewControllers([controller], animated: false)

    let contributor = FlowContributor.contribute(
      withNextPresentable: controller,
      withNextStepper: controller
    )

    return .one(flowContributor: contributor)
  }

  private func navigateToDetailApp(with appId: Int) -> FlowContributors {
    var container = DetailAppDIContainer(with: service)
    let controller = container.getController()
    controller.appId = appId
    rootViewController.pushViewController(controller, animated: true)

    let contributor = FlowContributor.makeContributor(withNextPresentable: controller)

    return .one(flowContributor: contributor)
  }

  private func dismissDetailAppController() -> FlowContributors {
    rootViewController.popViewController(animated: true)
    return .none
  }
}

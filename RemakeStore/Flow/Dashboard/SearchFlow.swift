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
    case .appDetailIsRequired(let appId):
      return navigateToAppDetail(with: appId)
    case .appDetailIsComplete:
      return dismissAppDetailScreen()
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

  private func navigateToAppDetail(with appId: Int) -> FlowContributors {
    var container = AppDetailDIContainer(with: service, appId: appId)
    let controller = container.getController()
    rootViewController.pushViewController(controller, animated: true)

    let contributor = FlowContributor.makeContributor(withNextPresentable: controller)

    return .one(flowContributor: contributor)
  }

  private func dismissAppDetailScreen() -> FlowContributors {
    rootViewController.popViewController(animated: true)
    return .none
  }
}

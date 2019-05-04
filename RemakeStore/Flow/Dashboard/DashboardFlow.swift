//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow

class DashboardFlow: BaseFlow {

  // MARK: - Private

  private let rootViewController: DashboardController = {
    let controller = DashboardController()
    controller.view.backgroundColor = .yellow
    return controller
  }()

  let service: Service

  // MARK: - Initializing
  required init(with service: Service) {
    self.service = service
  }

  // MARK: - Protocol Variables

  var root: Presentable {
    return rootViewController
  }

  // MARK: - functions for protocol

  public func navigate(to step: AppStep) -> FlowContributors {
    switch step {
    case .dashboardIsRequired:
      return navigateToDashboard()
    default:
      return .none
    }
  }

  // MARK: - Private

  private func navigateToDashboard() -> FlowContributors {
    let searchFlow = SearchFlow(with: service)
    Flows.whenReady(flow1: searchFlow) {
      self.rootViewController.setViewControllers([
        $0
      ], animated: false)
    }

    let contributor = makeContributor(
      with: .dashboardIsComplete,
      flow: searchFlow
    )
    return .one(flowContributor: contributor)
  }
}

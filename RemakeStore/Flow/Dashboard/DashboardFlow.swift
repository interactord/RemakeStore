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
    let todayFlow = TodayFlow(with: service)
    let appsFlow = AppsFlow(with: service)
    let musicFlow = MusicFlow(with: service)
    let searchFlow = SearchFlow(with: service)

    Flows.whenReady(
      flow1: todayFlow,
      flow2: appsFlow,
      flow3: musicFlow,
      flow4: searchFlow
    ) {
      self.rootViewController.setViewControllers([
        $0, $1, $2, $3
      ], animated: false)
    }

    let contributors = makeContributors(
      with: .dashboardIsComplete, flows: [
        todayFlow,
        appsFlow,
        musicFlow,
        searchFlow
      ])

    return .multiple(flowContributors: contributors)
  }

  private func makeContributors(with step: AppStep, flows: [Flow]) -> [FlowContributor] {
    return flows.map {
      FlowContributor.makeContributor(with: step, flow: $0)
    }
  }
}

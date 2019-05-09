//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import RxFlow

class LaunchFlow: BaseFlow {

  // MARK: - Private

  private let rootViewController: UINavigationController = {
    let navController = UINavigationController()
    navController.setNavigationBarHidden(true, animated: false)
    return navController
  }()

  // MARK: - Protocol Variables

  var service: Service

  public var root: Presentable {
    return rootViewController
  }

  // MARK: - Initializing

  required init(with service: Service) {
    self.service = service
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

  private func navigateToDashboard() -> FlowContributors {

    let dashboardFlow = DashboardFlow(with: service)

    Flows.whenReady(flow1: dashboardFlow) { [unowned self] root in
      DispatchQueue.main.async {
        self.rootViewController.pushViewController(root, animated: false)
      }
    }

    let contributor = FlowContributor.makeContributor(with: .dashboardIsRequired, flow: dashboardFlow)
    return .one(flowContributor: contributor)
  }
}

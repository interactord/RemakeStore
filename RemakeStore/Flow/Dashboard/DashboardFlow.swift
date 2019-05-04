//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow

class DashboardFlow {

  // MARK: - Private

  private let rootViewController: DashboardController = {
    let controller = DashboardController()
    controller.view.backgroundColor = .yellow
    return controller
  }()

  private let service: Service

  // MARK: - Initializing
  init(with service: Service) {
    self.service = service
  }

}

extension DashboardFlow: BaseFlow {

  // MARK: - Protocol Variables

  public var root: Presentable {
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
    return .none
  }
}

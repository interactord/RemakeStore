//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import RxFlow

class LaunchFlow {

  // MARK: - Private

  private let rootViewController: UINavigationController = {
    let navController = UINavigationController()
    navController.setNavigationBarHidden(true, animated: false)
    return navController
  }()

  let service: Service

  // MARK: - Initializing
  init(with service: Service) {
    self.service = service
  }

  deinit {
    print("\(type(of: self)): \(#function)")
  }

}

extension LaunchFlow: Flow {

  // MARK: - Protocol Variables
  public var root: Presentable {
    return rootViewController
  }

  // MARK: - functions for protocol
  public func navigate(to step: Step) -> FlowContributors {

    guard let step = step as? AppStep else {
      return .none
    }

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

    return .one(
      flowContributor: .contribute(
        withNextPresentable: dashboardFlow,
        withNextStepper: OneStepper(withSingleStep: AppStep.dashboardIsRequired)
      ))
  }
}

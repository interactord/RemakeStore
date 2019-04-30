//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow

class DashboardFlow {

	// MARK: - Private

	private let rootViewController: UITabBarController = {
		let controller = UITabBarController()
		controller.view.backgroundColor = .yellow
		return controller
	}()

	// MARK: - Initializing
	init() {
	}

	deinit {
	  print("\(type(of: self)): \(#function)")
	}

}

extension DashboardFlow: Flow {

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
		return .none
	}
}

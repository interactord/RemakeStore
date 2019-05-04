//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow

class TodayFlow: BaseFlow {

	// MARK: - Private

	let service: Service

	private lazy var rootViewController: UINavigationController = {
		var container = TodayDIContainer(with: service)
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
		return .none
	}
}

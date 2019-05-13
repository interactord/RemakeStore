//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow

class MusicFlow: BaseFlow {

	// MARK: - Private

	private lazy var rootViewController: UINavigationController = {
		var container = MusicDIContainer(with: service)
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
		return .none
	}
}

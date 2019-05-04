//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow

protocol BaseFlow: Flow {
	associatedtype ServiceType
	var service: ServiceType { get }

	init(with service: Service)
	func navigate(to step: AppStep) -> FlowContributors
}

extension BaseFlow {

	func navigate(to step: Step) -> FlowContributors {
		guard let step = step as? AppStep else {
			return  .none
		}
		return navigate(to: step)
	}
}

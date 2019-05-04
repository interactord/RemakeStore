//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import RxFlow

extension FlowContributor {
	static func makeContributor(with step: AppStep, flow: Flow) -> FlowContributor {
		let step = OneStepper(withSingleStep: step)
		return .contribute(withNextPresentable: flow, withNextStepper: step)
	}
}

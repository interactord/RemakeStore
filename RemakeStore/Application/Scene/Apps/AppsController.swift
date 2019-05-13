//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

class AppsController: BaseController {

	// MARK: - ViewModel

	var viewModel: AppsViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .green
	}

}

extension AppsController: ViewModelBased {

	// MARK: - functions for protocol

	func bindViewModel() {
		print("AppsController")
	}
}

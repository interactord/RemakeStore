//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

class MusicController: BaseController {

	// MARK: - ViewModel

	var viewModel: MusicViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .red
	}

}

extension MusicController: ViewModelBased {

	// MARK: - functions for protocol

	func bindViewModel() {
		print("MusicController")
	}
}

//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift

extension UIViewController {

	var viewWillAppearAction: Observable<Void> {
		return action(selector: #selector(self.viewWillAppear(_:)))
	}

	var viewWillDisappearAction: Observable<Void> {
		return action(selector: #selector(self.viewWillDisappear(_:)))
	}

	var viewDidLoadAction: Observable<Void> {
		return action(selector: #selector(self.viewDidLoad))
	}

	// MARK: - Private

	private func action(selector: Selector) -> Observable<Void> {
		/// Swizzling
		return rx.sentMessage(selector)
			.mapToVoid()
			.share(replay: 1)
	}
}

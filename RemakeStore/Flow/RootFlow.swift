//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow
import RxCocoa
import RxSwift

class RootFlow {

	// MARK: - Private

	private let disposeBag = DisposeBag()
	private let coordinator = FlowCoordinator()

	// MARK: - Initializing
	init() {
	}

	deinit {
	  print("\(type(of: self)): \(#function)")
	}
}

extension RootFlow {

	func onDebugNavigate() {

		self.coordinator.rx
			.willNavigate
			.subscribe(onNext: {
				print("Dill navigate to flow=\($0) and step=\($0)")
			}).disposed(by: disposeBag)

		self.coordinator.rx
			.didNavigate
			.subscribe(onNext: {
				print("Did navigate to flow=\($0) and step=\($0)")
			}).disposed(by: disposeBag)
	}

	func start(with window: UIWindow) -> Bool {

		let viewController = UIViewController()
		viewController.view.backgroundColor = .red
		window.rootViewController = viewController
		window.makeKeyAndVisible()
		return true

	}
}

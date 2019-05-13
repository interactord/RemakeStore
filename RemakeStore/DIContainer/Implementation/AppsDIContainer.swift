//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import Swinject

struct AppsDIContainer: DIContainer {

	// MARK: - Protocol Variables

	let container: Container

	// MARK: - Private

	private let service: Service

	private lazy var viewModel: AppsViewModel = {
		let service = self.service
		container.register(AppsViewModel.self) { _ in
			AppsViewModel(with: service)
		}.inObjectScope(.weak)

		guard let viewModel = container.resolve(AppsViewModel.self) else {
			fatalError("Should be not nil")
		}
		return viewModel
	}()

	private lazy var controller: AppsController = {
		container.register(AppsController.self) { _ in
			AppsController()
		}.inObjectScope(.weak)

		guard let controller = container.resolve(AppsController.self) else {
			fatalError("Should be not nil")
		}

		let viewModel = self.viewModel
		controller.bind(to: viewModel)
		return controller
	}()

	lazy var navigationController: UINavigationController = {
		let controller = self.controller
		container.register(UINavigationController.self) { _ -> UINavigationController in
			UINavigationController(rootViewController: controller)
		}.inObjectScope(.weak)

		guard let navController = container.resolve(UINavigationController.self) else {
			fatalError("Should be not nil")
		}

		navController.makeTabBarStyle(with: "Apps", imageName: "Apps")
		return navController
	}()

	// MARK: - Initializing

	init(with service: Service) {
		self.service = service
		container = Container()
	}
}

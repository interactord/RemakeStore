//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import Swinject

struct MusicDIContainer: DIContainer {

	// MARK: - Protocol Variables

	let container: Container

	// MARK: - Private

	private let service: Service

	private lazy var viewModel: MusicViewModel = {
		let service = self.service
		container.register(MusicViewModel.self) { _ in
			MusicViewModel(with: service)
		}.inObjectScope(.weak)

		guard let viewModel = container.resolve(MusicViewModel.self) else {
			fatalError("Should be not nil")
		}
		return viewModel
	}()

	private lazy var controller: MusicController = {
		container.register(MusicController.self) { _ in
			MusicController()
		}.inObjectScope(.weak)

		guard let controller = container.resolve(MusicController.self) else {
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

		navController.makeTabBarStyle(with: "Music", imageName: "Music")
		return navController
	}()

	// MARK: - Initializing

	init(with service: Service) {
		self.service = service
		container = Container()
	}
}

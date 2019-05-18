//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import Swinject

struct TodayDIContainer: DIContainer {

	// MARK: - Protocol Variables

	let container: Container

	// MARK: - Private

	private let service: Service

	private(set) lazy var rssRepository: RssRepository = {
		let baseUrl = "https://rss.itunes.apple.com"
		let service = self.service
		container.register(RssRepository.self) { _ in
			RssRepository(
				httpClient: service.httpClient,
				baseURL: baseUrl
			)
		}.inObjectScope(.weak)

		guard let repository = container.resolve(RssRepository.self) else {
			fatalError("Should be not nil")
		}

		return repository
	}()

	private(set) lazy var interactordRepository: InteractordRepository = {
		let baseUrl = "https://astore.interactord.io"
		let service = self.service
		container.register(InteractordRepository.self) { _ in
			InteractordRepository(
				httpClient: service.httpClient,
				baseUrl: baseUrl
			)
		}.inObjectScope(.weak)

		guard let repository = container.resolve(InteractordRepository.self) else {
			fatalError("Should be not nil")
		}

		return repository
	}()

	private(set) lazy var viewModel: TodayViewModel = {
		let service = self.service
		let rssRepository = self.rssRepository
		let interactordRepository = self.interactordRepository

		container.register(TodayViewModel.self) { _ in
			TodayViewModel(
				with: service,
				interactordRepository: interactordRepository,
				rssRepository: rssRepository
			)
		}.inObjectScope(.weak)

		guard let viewModel = container.resolve(TodayViewModel.self) else {
			fatalError("Should be not nil")
		}
		return viewModel
	}()

	private(set) lazy var controller: TodayController = {
		container.register(TodayController.self) { _ in
			TodayController()
		}.inObjectScope(.weak)

		guard let controller = container.resolve(TodayController.self) else {
			fatalError("Should be not nil")
		}

		let viewModel = self.viewModel
		controller.bind(to: viewModel)
		return controller
	}()

	private(set) public lazy var navigationController: UINavigationController = {
		container.register(UINavigationController.self) { _ -> UINavigationController in
			UINavigationController()
		}.inObjectScope(.weak)

		guard let navController = container.resolve(UINavigationController.self) else {
			fatalError("Should be not nil")
		}

		navController.makeTabBarStyle(with: "Today", imageName: "Today")
		return navController
	}()

	// MARK: - Initializing

	init(with service: Service) {
		self.service = service
		container = Container()
	}

	// MARK: Public

	mutating func getController() -> TodayController {
		return self.controller
	}

}

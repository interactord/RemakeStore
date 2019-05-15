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

  private(set) lazy var viewModel: AppsViewModel = {
    let service = self.service
    let rssRepository = self.rssRepository
    container.register(AppsViewModel.self) { _ in
      AppsViewModel(
        with: service,
        rssRepository: rssRepository
      )
    }.inObjectScope(.weak)

    guard let viewModel = container.resolve(AppsViewModel.self) else {
      fatalError("Should be not nil")
    }
    return viewModel
  }()

  private(set) lazy var controller: AppsController = {
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

  // MARK: - Public

  private(set) public lazy var navigationController: UINavigationController = {
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

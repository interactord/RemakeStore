//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import Swinject

struct SearchDIContainer: DIContainer {
  let container: Container
  let service: Service

  private lazy var viewModel: SearchViewModel = {
    let service = self.service
    container.register(SearchViewModel.self) { _ in
      SearchViewModel(with: service)
    }.inObjectScope(.weak)

    guard let viewModel = container.resolve(SearchViewModel.self) else {
      fatalError("Should be not nil")
    }
    return viewModel
  }()

  private lazy var controller: SearchController = {
    container.register(SearchController.self) { _ in
      SearchController()
    }.inObjectScope(.weak)

    guard let controller = container.resolve(SearchController.self) else {
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

    navController.makeTabBarStyle(with: "Search", imageName: "Search")
    return navController
  }()

  // MARK: - Initializing
  init(with service: Service) {
    self.service = service
    container = Container()
  }
}

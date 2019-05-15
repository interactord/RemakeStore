//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import Swinject
import SCServiceKit

struct SearchDIContainer: DIContainer {

  // MARK: - Protocol Variables

  let container: Container

  // MARK: - Private

  private let service: Service

  private(set) lazy var repository: ITunesRepository = {
    let service = self.service
    let baseUrl = "https://itunes.apple.com"
    container.register(ITunesRepository.self) { _ in
      ITunesRepository(httpClient: service.httpClient, baseUrl: baseUrl)
    }.inObjectScope(.weak)

    guard let repository = container.resolve(ITunesRepository.self) else {
      fatalError("Should be not nil")
    }
    return repository
  }()

  private(set) lazy var viewModel: SearchViewModel = {
    let service = self.service
    let repository = self.repository
    container.register(SearchViewModel.self) { _ in
      SearchViewModel(
        with: service,
        iTunesRepository: repository
      )
    }.inObjectScope(.weak)

    guard let viewModel = container.resolve(SearchViewModel.self) else {
      fatalError("Should be not nil")
    }
    return viewModel
  }()

  private(set) lazy var controller: SearchController = {
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

  private(set) lazy var navigationController: UINavigationController = {
    container.register(UINavigationController.self) { _ -> UINavigationController in
      UINavigationController()
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

  // MARK: Public

  mutating func getController() -> SearchController {
    return controller
  }
}

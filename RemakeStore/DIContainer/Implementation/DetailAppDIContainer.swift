//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import Swinject

struct DetailAppDIContainer: DIContainer {
  let container: Container
  let service: Service
  let appId: Int

  private lazy var viewModel: DetailAppViewModel = {
    let service = self.service
    container.register(DetailAppViewModel.self) { _ in
      DetailAppViewModel(with: service)
    }.inObjectScope(.weak)

    guard let viewModel = container.resolve(DetailAppViewModel.self) else {
      fatalError("Should be not nil")
    }
    return viewModel
  }()

  private lazy var controller: DetailAppController = {
    container.register(DetailAppController.self) { _ in
      DetailAppController()
    }.inObjectScope(.weak)

    guard let controller = container.resolve(DetailAppController.self) else {
      fatalError("Should be not nil")
    }

    let viewModel = self.viewModel
    let appId = self.appId
    controller.bind(to: viewModel) {
      controller.appId = appId
    }
    return controller
  }()

  // MARK: - Initializing
  init(with service: Service, appId: Int) {
    self.service = service
    self.appId = appId
    container = Container()
  }

  mutating func getController() -> DetailAppController {
    return self.controller
  }
}

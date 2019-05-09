//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import Swinject

struct AppDetailDIContainer: DIContainer {
  let container: Container
  let service: Service
  let appId: Int

  private lazy var viewModel: AppDetailViewModel = {
    let service = self.service
    container.register(AppDetailViewModel.self) { _ in
      AppDetailViewModel(with: service)
    }.inObjectScope(.weak)

    guard let viewModel = container.resolve(AppDetailViewModel.self) else {
      fatalError("Should be not nil")
    }
    return viewModel
  }()

  private lazy var controller: AppDetailController = {
    container.register(AppDetailController.self) { _ in
      AppDetailController()
    }.inObjectScope(.weak)

    guard let controller = container.resolve(AppDetailController.self) else {
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

  mutating func getController() -> AppDetailController {
    return self.controller
  }
}

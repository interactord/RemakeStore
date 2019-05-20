//
// Created by Scott Moon on 2019-05-21.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import Swinject

struct TodayDetailDIContainer: DIContainer {

  // MARK: - Protocol Variables

  let container: Container

  // MARK: - Private

  private let service: Service
  private let todayItemViewModel: TodayItemViewModeling

  private(set) lazy var viewModel: TodayDetailViewModel = {
    let service = self.service
    let todayItemViewModel = self.todayItemViewModel

    container.register(TodayDetailViewModel.self) { _ in
      TodayDetailViewModel(
        with: service,
        todayItemViewModel: todayItemViewModel
      )
    }.inObjectScope(.weak)

    guard let viewModel = container.resolve(TodayDetailViewModel.self) else {
      fatalError("Should be not nil")
    }
    return viewModel
  }()

  private(set) lazy var controller: TodayDetailController = {
    container.register(TodayDetailController.self) { _ in
      TodayDetailController()
    }.inObjectScope(.weak)

    guard let controller = container.resolve(TodayDetailController.self) else {
      fatalError("Should be not nil")
    }

    let viewModel = self.viewModel
    controller.bind(to: viewModel)
    return controller
  }()

  // MARK: - Initializing

  init(with service: Service, todayItemViewModel: TodayItemViewModeling) {
    self.service = service
    self.todayItemViewModel = todayItemViewModel
    container = Container()
  }

  // MARK: Public

  mutating func getController() -> TodayDetailController {
    return self.controller
  }

}

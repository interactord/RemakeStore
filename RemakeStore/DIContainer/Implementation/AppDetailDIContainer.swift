//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import Swinject
import SCServiceKit

struct AppDetailDIContainer: DIContainer {

  // MARK: - Protocol Variables

  let container: Container

  // MARK: - Private

  private let service: Service
  private let appId: Int

  private lazy var lookupRepository: AnyRepository<Lookup> = {
    let service = self.service
    container.register(AnyRepository<Lookup>.self) { _ in
      AnyRepository<Lookup>(base: LookupRepository(
        httpClient: service.httpClient
      ))
    }.inObjectScope(.weak)

    guard let repository = container.resolve(AnyRepository<Lookup>.self) else {
      fatalError("Should be not nil")
    }
    return repository
  }()

  private lazy var reviewsRepository: AnyRepository<Reviews> = {
    let service = self.service
    container.register(AnyRepository<Reviews>.self) { _ in
      AnyRepository<Reviews>(base: ReviewsRepository(
        httpClient: service.httpClient
      ))
    }.inObjectScope(.weak)

    guard let repository = container.resolve(AnyRepository<Reviews>.self) else {
      fatalError("Should be not nil")
    }
    return repository
  }()

  private lazy var viewModel: AppDetailViewModel = {
    let service = self.service
    let lookupRepository = self.lookupRepository
    let reviewsRepository = self.reviewsRepository
    container.register(AppDetailViewModel.self) { _ in
      AppDetailViewModel(
        with: service,
        lookupRepository: lookupRepository,
        reviewsRepository: reviewsRepository
      )
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

  // MARK: Public

  mutating func getController() -> AppDetailController {
    return self.controller
  }
}

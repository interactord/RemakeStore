//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow
import RxCocoa
import RxSwift

class RootFlow {

  // MARK: - Private

  private let disposeBag = DisposeBag()
  private let coordinator = FlowCoordinator()
  private let service: Service

  // MARK: - Initializing

  init(with service: Service) {
    self.service = service
  }

  deinit {
    print("\(type(of: self)): \(#function)")
  }
}

extension RootFlow {

  func onDebugNavigate() {

    let logger = service.logger
    self.coordinator.rx
      .willNavigate
      .subscribe(onNext: {
        logger.log(level: .info, message: "Will navigate to flow=\($0) and step=\($0)")
      }).disposed(by: disposeBag)

    self.coordinator.rx
      .didNavigate
      .subscribe(onNext: {
        logger.log(level: .info, message: "Did navigate to flow=\($0) and step=\($0)")
      }).disposed(by: disposeBag)

  }

  func start(with window: UIWindow) {

    let launchFlow = LaunchFlow(with: service)

    Flows.whenReady(flow1: launchFlow) { root in
      window.rootViewController = root
      window.makeKeyAndVisible()
    }

    coordinator.coordinate(flow: launchFlow, with: LaunchStepper())

  }
}

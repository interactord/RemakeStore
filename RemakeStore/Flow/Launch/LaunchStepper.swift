//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow
import RxCocoa
import RxSwift

class LaunchStepper {

  // MARK: - Private

  let disposeBag = DisposeBag()

  // MARK: - Initializing
  init() {
  }

  deinit {
    print("\(type(of: self)): \(#function)")
  }
}

extension LaunchStepper: Stepper {

  // MARK: - Protocol Variables

  public var steps: PublishRelay<Step> {
    return PublishRelay<Step>()
  }

  var initialStep: Step {
    return AppStep.dashboardIsRequired
  }

}

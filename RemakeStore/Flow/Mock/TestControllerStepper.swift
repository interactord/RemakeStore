//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow
import RxSwift
import RxCocoa

class TestControllerStepper: UIViewController {
}

extension TestControllerStepper: Stepper {
  var steps: PublishRelay<Step> {
    return PublishRelay<Step>()
  }
}

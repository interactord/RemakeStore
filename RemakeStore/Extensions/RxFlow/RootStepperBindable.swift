//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import RxFlow
import RxCocoa

protocol RootStepperBindable {
  func bind(to stepper: PublishRelay<Step>)
}

//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxFlow

enum AppStep: Step {

  /// Global
  case none

  /// Dashboard
  case dashboardIsRequired
  case dashboardIsComplete

  /// DetailApp
  case detailAppIsRequired
  case detailAppIsComplete
}

//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxFlow

@testable import RemakeStore

class BaseFlowMock: BaseFlow {

  let service: Service

  required init(with service: Service) {
    self.service = service
  }

  var root: Presentable {
    return UIViewController()
  }

  func navigate(to step: AppStep) -> FlowContributors {
    let flow = BaseFlowMock(with: service)
    let contributor = makeContributor(with: .none, flow: flow)
    return .one(flowContributor: contributor)
  }

}

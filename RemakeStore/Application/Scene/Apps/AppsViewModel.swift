//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

protocol AppsViewModelInput {
  
}

protocol AppsViewModelOutput {
}

protocol AppsViewModeling {
  var inputs: AppsViewModelInput { get }
  var outputs: AppsViewModelOutput { get }
}

typealias AppsViewModelType =
  AppsViewModelInput & AppsViewModelOutput & AppsViewModeling

class AppsViewModel: ServiceViewModel, AppsViewModelType {

  // MARK: - Inputs & Outputs

  var inputs: AppsViewModelInput {
    return self
  }

  var outputs: AppsViewModelOutput {
    return self
  }

  // MARK: - Protocol Variables

  let service: Service

  // MARK: - Initializing

  required init(with service: Service) {
    self.service = service
  }
}

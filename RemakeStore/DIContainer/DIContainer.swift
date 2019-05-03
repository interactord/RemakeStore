//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

protocol DIContainer {
  associatedtype DependencyContainer
  var container: DependencyContainer { get }
}

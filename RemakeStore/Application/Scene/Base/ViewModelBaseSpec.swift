//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import UIKit

@testable import RemakeStore

class ViewModelBaseSpec: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func test_viewController_bind() {
    let viewController = ViewModelBaseViewController()
    let viewModel = TestViewModelMock()
    viewController.bind(to: viewModel)
  }

  func test_collectionView_bind() {
    var container = ServiceDIContainer()
    let service = container.service

    let cell = ViewModelBasedCollectionViewCellMock(frame: .zero)
    let viewModel = ServiceViewModelMock(with: service)
    cell.bind(to: viewModel)
  }

  func test_tableViewCell_bind() {
    let cell = ViewModelBasedTableViewCellMock(frame: .zero)
    let viewModel = TestViewModelMock()
    cell.bind(to: viewModel)
  }

  func test_reusableCell_bind() {
    let cell = ViewModelBasedCRViewCellMock(frame: .zero)
    let viewModel = TestViewModelMock()
    cell.bind(to: viewModel)
  }
}

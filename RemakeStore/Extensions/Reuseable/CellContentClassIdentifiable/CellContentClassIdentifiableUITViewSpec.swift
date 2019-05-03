//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import UIKit
@testable import RemakeStore
class CellContentClassIdentifiableUITViewSpec: XCTestCase {

  var sut: UITableView?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_inject_mock_register_and_dequeueReuseCell() {

    sut = UITableView(frame: .zero)

    guard let sut = sut else {
      fatalError("Should be not nil")
    }

    sut.register(cellType: TestTableViewCellMock.self)
    let cell: TestTableViewCellMock = sut.dequeueReusableCell(indexPath: [0, 0])

    XCTAssertNotNil(cell)
  }

}

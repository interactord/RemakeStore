//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import UIKit
@testable import RemakeStore

class CellContentClassIdentifiableUICViewSpec: XCTestCase {

  var sut: UICollectionView?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_inject_mock_register_and_dequeueReuseCell() {
    let layout = UICollectionViewFlowLayout()
    sut = UICollectionView(frame: .zero, collectionViewLayout: layout)

    guard let sut = sut else {
      fatalError("Should be not nil")
    }

    sut.register(cellType: TestCollectionViewCellMock.self)
    let cell: TestCollectionViewCellMock = sut.dequeueReusableCell(indexPath: [0, 0])

    XCTAssertNotNil(cell)
  }

}

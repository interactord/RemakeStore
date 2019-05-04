//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest

import UIKit

@testable import RemakeStore

class UINavigationControllerStyleSpec: XCTestCase {

  var sut: UINavigationController?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_makeTabBarStyle() {
    let controller = UIViewController()

    sut = UINavigationController(rootViewController: controller)
    sut?.makeTabBarStyle(with: "test", imageName: "test")
  }

}

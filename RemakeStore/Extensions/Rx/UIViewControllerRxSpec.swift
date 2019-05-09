//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import UIKit

import RxSwift

@testable import RemakeStore

class UIViewControllerRxSpec: XCTestCase {

  var disposeBag: DisposeBag?
  var sut: UIViewController?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    disposeBag = nil
    sut = nil
  }

  func test_swizzling_viewWillAppearAction() {
    let expectedCell = XCTestExpectation(description: "called event")

    sut = UIViewController()
    disposeBag = DisposeBag()

    guard
      let sut = sut,
      let disposeBag = disposeBag
      else {
        fatalError("Should be not nil")
    }

    sut.viewWillAppearAction
      .subscribe(onNext: { _ in
        expectedCell.fulfill()
      }).disposed(by: disposeBag)

    sut.viewWillAppear(true)

    wait(for: [expectedCell], timeout: 5.0)

  }

  func test_swizzling_viewWillDisappearAction() {
    let expectedCell = XCTestExpectation(description: "called event")

    sut = UIViewController()
    disposeBag = DisposeBag()

    guard
      let sut = sut,
      let disposeBag = disposeBag
      else {
        fatalError("Should be not nil")
    }

    sut.viewWillDisappearAction
      .subscribe(onNext: { _ in
        expectedCell.fulfill()
      }).disposed(by: disposeBag)

    sut.viewWillDisappear(true)

    wait(for: [expectedCell], timeout: 5.0)

  }

}

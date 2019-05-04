//
// Created by Scott Moon on 2019-05-03.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import Foundation

import RxSwift
@testable import SCServiceKit

class AnyRepositorySpec: XCTestCase {

  let stubServer = StubServer()
  var disposeBag: DisposeBag?
  var sutUser: AnyRepository<UserMock>?
  var sutUserDecodable: AnyRepository<UserDecodableMock>?

  override func setUp() {
    super.setUp()
    stubServer.setup()
    disposeBag = DisposeBag()
  }

  override func tearDown() {
    super.tearDown()
    stubServer.tearDown()
    disposeBag = nil
    sutUser = nil
    sutUserDecodable = nil
  }

  func test_inject_userRepositoryMock_and_appClient_create_delete() {
    let httpClientMock = MockBuilder.makeAppHttpClient()
    let expectedCreateCall = XCTestExpectation(description: "test_inject_userRepositoryMock_and_appClient_create")
    let expectedDeleteCall = XCTestExpectation(description: "test_inject_userRepositoryMock_and_appClient_delete")

    sutUser = AnyRepository<UserMock>(base: UserRepositoryMock(httpClient: httpClientMock))

    guard
      let sut = sutUser,
      let disposeBag = disposeBag
      else {
        fatalError("Should be not nil")
    }

    sut.create(with: nil)
      .subscribe(
        onNext: { _ in
          XCTFail("Should be no result")
        },
        onError: { err in
          XCTAssertNotNil(err)
          expectedCreateCall.fulfill()
        }
      ).disposed(by: disposeBag)

    sut.delete(with: nil)
      .subscribe(
        onNext: { _ in
          XCTFail("Should be no result")
        },
        onError: { err in
          XCTAssertNotNil(err)
          expectedDeleteCall.fulfill()
        }
      ).disposed(by: disposeBag)

    wait(for: [expectedCreateCall, expectedDeleteCall], timeout: 5.0)

  }

  func test_inject_userDecodeMock_and_appClient_create_delete() {
    let httpClientMock = MockBuilder.makeAppHttpClient()
    let expectedCreateCall = XCTestExpectation(description: "test_inject_userDecodeMock_and_appClient_create")
    let expectedDeleteCall = XCTestExpectation(description: "test_inject_userDecodeMock_and_appClient_create")

    sutUserDecodable = AnyRepository<UserDecodableMock>(base: UserDecodableRepoMock(httpClient: httpClientMock))

    guard
      let sut = sutUserDecodable,
      let disposeBag = disposeBag
      else {
      fatalError("Should be not nil")
    }

    sut.create(with: nil)
      .subscribe(
        onNext: { _ in
          XCTFail("Should be no result")
        },
        onError: { err in
          XCTAssertNotNil(err)
          expectedCreateCall.fulfill()
        }
      ).disposed(by: disposeBag)

    sut.delete(with: nil)
      .subscribe(
        onNext: { _ in
          XCTFail("Should be no result")
        },
        onError: { err in
          XCTAssertNotNil(err)
          expectedDeleteCall.fulfill()
        }
      ).disposed(by: disposeBag)

    wait(for: [expectedCreateCall, expectedDeleteCall], timeout: 5.0)

  }

  func test_inject_userMock_and_appClient_update() {
    let httpClientMock = MockBuilder.makeAppHttpClient()
    let updateUserParameterMock = UpdateUserParameterMock(name: "test user", surname: "test surname")

    let expectedCall = XCTestExpectation(description: "call proceed")
    let expectedUserMock = UserMock(name: "test name", surname: "test surname", age: "34")

    sutUser = AnyRepository<UserMock>(base: UserRepositoryMock(httpClient: httpClientMock))

    guard
      let sut = sutUser,
      let disposeBag = disposeBag
      else {
      fatalError("Should be not nil")
    }

    sut.update(with: updateUserParameterMock)
      .subscribe(onNext: { result in

        switch result {
        case .noContent:
          XCTFail("Should be no content")
        case .value(let userMock):
          XCTAssertEqual(expectedUserMock.name, userMock.name)
          XCTAssertEqual(expectedUserMock.surname, userMock.surname)
        }

        expectedCall.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectedCall], timeout: 5.0)

  }

  func test_inject_userDecodeMock_and_appClient_update() {
    let httpClientMock = MockBuilder.makeAppHttpClient()
    let updateUserParameterMock = UpdateUserParameterMock(name: "test user", surname: "test surname")

    let expectedCall = XCTestExpectation(description: "call proceed")
    let expectedUserMock = UserMock(name: "test name", surname: "test surname", age: "34")

    sutUserDecodable = AnyRepository<UserDecodableMock>(base: UserDecodableRepoMock(httpClient: httpClientMock))

    guard
      let sut = sutUserDecodable,
      let disposeBag = disposeBag
      else {
      fatalError("Should be not nil")
    }

    sut.update(with: updateUserParameterMock)
      .subscribe(onNext: { result in

        switch result {
        case .noContent:
          XCTFail("Should be no content")
        case .value(let userMock):
          XCTAssertEqual(expectedUserMock.name, userMock.args.name)
          XCTAssertEqual(expectedUserMock.surname, userMock.args.surname)
        }

        expectedCall.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectedCall], timeout: 5.0)

  }

  func test_inject_userMock_and_appClient_read() {
    let httpClientMock = MockBuilder.makeAppHttpClient()
    let expectedCall = XCTestExpectation(description: "test_inject_userMock_and_appClient_read")
    let expectedUserMock = UserMock(name: "test name", surname: "test surname", age: "34")

    sutUser = AnyRepository<UserMock>(base: UserRepositoryMock(httpClient: httpClientMock))

    guard
      let sut = sutUser,
      let disposeBag = disposeBag
      else {
        fatalError("Should be not nil")
    }

    sut.read(with: nil)
      .subscribe(onNext: { result in

        switch result {
        case .noContent:
          XCTFail("Should be no content")
        case .value(let userMock):
          XCTAssertEqual(expectedUserMock.name, userMock.name)
          XCTAssertEqual(expectedUserMock.surname, userMock.surname)
          XCTAssertEqual(expectedUserMock.age, userMock.age)
        }

        expectedCall.fulfill()
      }).disposed(by: disposeBag)

    wait(for: [expectedCall], timeout: 5.0)

  }

  func test_inject_userDecodeMock_and_appClient_read() {
    let httpClientMock = MockBuilder.makeAppHttpClient()
    let expectedCall = XCTestExpectation(description: "test_inject_userDecodeMock_and_appClient_read")
    let expectedUserMock = UserDecodableChildMock(name: "test name", surname: "test surname", age: "34")

    sutUserDecodable = AnyRepository<UserDecodableMock>(base: UserDecodableRepoMock(httpClient: httpClientMock))

    guard
      let sut = sutUserDecodable,
      let disposeBag = disposeBag
      else {
        fatalError("Should be not nil")
    }

    sut.read(with: nil)
      .subscribe(
        onNext: { result in

          switch result {
          case .noContent:
            XCTFail("Should be no content")
          case .value(let userMock):
            XCTAssertEqual(expectedUserMock.name, userMock.args.name)
            XCTAssertEqual(expectedUserMock.surname, userMock.args.surname)
            XCTAssertEqual(expectedUserMock.age, userMock.args.age)
          }
          expectedCall.fulfill()
        }).disposed(by: disposeBag)

    wait(for: [expectedCall], timeout: 5.0)
  }

}

//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import XCTest
import Foundation

import RxSwift
@testable import SCServiceKit

class AppHTTPClientSpec: XCTestCase {

	var disposeBag: DisposeBag?
	var sut: AppHTTPClient?
	let stubServer = StubServer()

	override func setUp() {
		super.setUp()
		stubServer.setup()
		disposeBag = DisposeBag()
	}

	override func tearDown() {
		super.tearDown()
		disposeBag = nil
		sut = nil
		stubServer.tearDown()
	}

	func test_inject_endpoint_request() {

    let expectedCall = XCTestExpectation(description: "call proceed")

		sut = AppHTTPClient(
			transformer: MockBuilder.makeTransformer(),
			networkAdapter: MockBuilder.makeNetworkAdapter(),
			requestChain: InterceptorChain<URLRequest>(),
			responseChain: InterceptorChain<Response>(),
			httpErrorHandler: TestHTTPErrorHandlerMock()
		)

		guard
			let sut = sut,
			let disposeBag = disposeBag
			else {
			fatalError("Should be not nil")
		}

		sut.request(endpoint: MockBuilder.makeEndpointNoContentsMock())
			.subscribe(onNext: { response in
				XCTAssertNotNil(response)
        expectedCall.fulfill()
			}).disposed(by: disposeBag)

		wait(for: [expectedCall], timeout: 5.0)
	}

}

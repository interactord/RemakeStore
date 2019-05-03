//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

@testable import RemakeStore

class TestHTTPErrorHandlerMock: HTTPErrorHandler {

	// MARK: - functions for protocol

	func handle(response: Response) -> Error {

		/// All the error logic error of the api should be handle here
		return NetworkError(error: nil)
	}
}

//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

struct NetworkError {

	// MARK: - Private

	private let error: Error?
	private enum Constant {
		static let translationKey = "error.global.network"
	}

	// MARK: - Initializing
	init(error: Error? = nil) {
		self.error = error
	}
}

extension NetworkError: ErrorType {

	var raw: Error? {
		return error
	}

	var messageKey: String {
		return Constant.translationKey
	}

}

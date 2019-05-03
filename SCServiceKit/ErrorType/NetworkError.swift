//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public struct NetworkError {

	// MARK: - Private

	private let error: Error?
	private enum Constant {
		static let translationKey = "error.global.network"
	}

	// MARK: - Initializing
	public init(error: Error? = nil) {
		self.error = error
	}
}

extension NetworkError: ErrorType {

	public var raw: Error? {
		return error
	}

	public var messageKey: String {
		return Constant.translationKey
	}

}

//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public struct SerializationError {

	// MARK: - Private

	private let error: Error

	private enum Constant {
		static let translationKey = "error.global.default"
	}

	// MARK: - Initializing

	public init(error: Error) {
		self.error = error
	}

}

extension SerializationError: ErrorType {

	// MARK: - functions for protocol

	public var raw: Error? {
		return error
	}

	public var messageKey: String {
		return Constant.translationKey
	}
}

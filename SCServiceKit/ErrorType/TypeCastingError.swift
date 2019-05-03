//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public struct TypeCastingError {

	// MARK: - Private

	private let developerMessage: String

	private enum Constant {
		static let translationKey = "error.global"
	}

	// MARK: - Initializing

	public init(developerMessage: String) {
		self.developerMessage = developerMessage
	}
}

extension TypeCastingError: ErrorType {

	// MARK: - Protocol Variables
	public var raw: Error? {
		return nil
	}

	public var messageKey: String {
		return  Constant.translationKey
	}

}

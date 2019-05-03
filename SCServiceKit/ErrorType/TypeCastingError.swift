//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

struct TypeCastingError {

	// MARK: - Private

	private let developerMessage: String

	private enum Constant {
		static let translationKey = "error.global"
	}

	// MARK: - Initializing

	init(developerMessage: String) {
		self.developerMessage = developerMessage
	}
}

extension TypeCastingError: ErrorType {

	// MARK: - Protocol Variables
	var raw: Error? {
		return nil
	}

	var messageKey: String {
		return  Constant.translationKey
	}

}

//
// Created by Scott Moon on 2019-05-02.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

@testable import RemakeStore

struct UserMock: Deserializable {

	let name, surname, age: String

	private enum Keys {
		static let args = "args"
		static let name = "name"
		static let surname = "surname"
		static let age = "age"
	}

}

extension UserMock: JSONDeserializable {
	init(object: Any) throws {
		guard
			let dictionary = object as? [String: Any],
			let args = dictionary[Keys.args] as? [String: Any]
			else {
			throw DeserializationError(developerMessage: "[User] - Not a dictionary")
		}

		guard
			let name = args[Keys.name] as? String,
			let surname = args[Keys.surname] as? String,
			let age = args[Keys.age] as? String
			else {
			throw DeserializationError(developerMessage: "[User] - Missing key, value")
		}

		self.name = name
		self.surname = surname
		self.age = age

	}

}

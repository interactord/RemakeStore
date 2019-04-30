//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

protocol Deserializable {
	init(data: Data) throws
}

protocol AnyInitialization {
	init(object: Any) throws
}

extension Deserializable where Self: AnyInitialization {
	init(data: Data) throws {
		let object: Any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
		try self.init(object: object)
	}
}

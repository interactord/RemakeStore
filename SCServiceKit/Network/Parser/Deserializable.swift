//
// Created by Scott Moon on 2019-05-01.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

public protocol Deserializable {
	init(data: Data) throws
}

extension Deserializable where Self: JSONDeserializable {
	init(data: Data) throws {
		let object: Any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
		try self.init(object: object)
	}
}

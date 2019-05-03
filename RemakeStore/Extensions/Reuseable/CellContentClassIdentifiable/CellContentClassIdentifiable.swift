//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

protocol CellContentClassIdentifiable: class {
	static var reuseId: String { get }
}

extension CellContentClassIdentifiable {
	static var reuseId: String {
		return String(describing: self)
	}
}

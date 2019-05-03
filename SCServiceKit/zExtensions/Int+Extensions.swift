//
// Created by Scott Moon on 2019-05-03.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

extension Int {

	func increase(_ step: Int) -> Int {
		return self + step
	}

	func decrease(_ step: Int, min: Int) -> Int {
		if min > self {
			return 0
		}
		return self - step
	}
}

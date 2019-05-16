//
// Created by Scott Moon on 2019-05-17.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

struct TodayItem {
	enum CellType: String {
		case single, multiple
	}

	let category: String
	let title: String
	let image: UIImage
	let description: String
	let backgroundColor: UIColor
	let cellType: CellType
	let apps: [FeedResult]
}

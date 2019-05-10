//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCServiceKit

struct LookupReadParameter: RepositoryParameter {

	// MARK: Public

	let query: [String: String]

	// MARK: - Initializing

	init(withAppId appId: Int) {
		query = [
			"id": "\(appId)"
		]
	}
}

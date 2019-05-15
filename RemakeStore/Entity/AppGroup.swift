//
// Created by Scott Moon on 2019-05-15.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
	let feed: Feed
}

struct Feed: Decodable {
	let title: String
	let results: [FeedResult]
}

struct FeedResult: Decodable {
	let id, name, artistName, artworkUrl: String
}
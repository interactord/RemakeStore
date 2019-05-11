//
// Created by Scott Moon on 2019-05-09.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

struct Lookup: Decodable {

  struct Information: Decodable {
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    var screenshotUrls: [String]?
    let artworkUrl100: String
    var formattedPrice: String?
    var description: String?
    var releaseNotes: String?
    var artistName: String?
    var collectionName: String?
  }

  let resultCount: Int
  let results: [Information]
}

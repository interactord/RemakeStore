//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

struct Reviews: Decodable {
  let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
  let entry: [Entry]
}

struct Entry: Decodable {
  private enum CodingKeys: String, CodingKey {
    case author, title, content
    case rating = "im:rating"
  }

  let author: Author
  let title: Label
  let content: Label
  let rating: Label
}

struct Author: Decodable {
  let name: Label
}

struct Label: Decodable {
  let label: String
}

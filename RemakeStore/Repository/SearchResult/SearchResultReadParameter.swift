//
// Created by Scott Moon on 2019-05-09.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCServiceKit

struct SearchResultReadParameter: RepositoryParameter {

	let query: [String: String]

  init(withTerm term: String) {
    query = [
      "term": term,
      "entity": "software"
    ]
  }

}

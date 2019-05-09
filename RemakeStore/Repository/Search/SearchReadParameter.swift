//
// Created by Scott Moon on 2019-05-09.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCServiceKit

struct SearchReadParameter: RepositoryParameter {

  // MARK: - Private

	let query: [String: String]

  // MARK: - Initializing

  init(withTerm term: String) {
    query = [
      "term": term,
      "entity": "software"
    ]
  }

}

//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

enum ITunesEndpointRouter {
  case search(term: String)
  case lookup(appId: String)
  case review(appId: String)
}

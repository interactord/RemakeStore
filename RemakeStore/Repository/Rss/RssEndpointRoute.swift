//
// Created by Scott Moon on 2019-05-15.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

enum RssEndpointRouter: String {
  case topGrossing = "api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
  case newGames = "api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
  case topFree = "api/v1/us/ios-apps/top-free/all/50/explicit.json"
}

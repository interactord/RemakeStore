//
// Created by Scott Moon on 2019-05-17.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

struct TodayItem: Decodable {
  let category: String
  let title: String
  let imageUrl: String
  let description: String
  let theme: String
  let cellType: String
  let rssUrl: String
  let lookupUrl: String
  let appGroup: AppsGroup?
}

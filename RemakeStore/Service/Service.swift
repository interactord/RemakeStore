//
// Created by Scott Moon on 2019-05-03.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import SCServiceKit

protocol Service {
  var httpClient: HTTPClient { get }
  var translator: Translator { get }
  var logger: Logger { get }
}

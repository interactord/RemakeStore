//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

extension String {
  func toInt() -> Int? {
    return Int(self)
  }

  func toHexColor() -> UIColor {
    var hexString = ""

    if self.hasPrefix("#") {
      hexString = String(self[self.index(after: self.startIndex)...])
    }

    guard let hexVal = Int(hexString, radix: 16) else {
      return UIColor()
    }

    switch hexString.count {
    case 3:
      return UIColor(hex3: hexVal, alpha: 1.0) ?? UIColor()
    case 6:
      return UIColor(hex6: hexVal, alpha: 1.0) ?? UIColor()
    default:
      return UIColor()
    }

  }

}

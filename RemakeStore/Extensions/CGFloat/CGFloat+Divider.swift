//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

extension CGFloat {
  func dividerHeight(padding: CGFloat, lineSpacing: CGFloat, grid: CGFloat) -> CGFloat {
    let bounce = self - (grid - 1) * padding - 2 * lineSpacing
    return  bounce / grid
  }

  func convertDragScaleTranform(withOffset offset: CGFloat) -> CGAffineTransform? {
    if self <= 0 {
      return nil
    }

    let trueOffset = self - offset
    var scale: CGFloat = 1 - trueOffset / 1_000
    scale = CGFloat.minMax(minValue: 1, maxValue: 0.5, tagetValue: scale)
    return .init(scaleX: scale, y: scale)
  }

  static func minMax(minValue: CGFloat, maxValue: CGFloat, tagetValue: CGFloat) -> CGFloat {
    var value = tagetValue
    value = Swift.min(minValue, value)
    value = Swift.max(maxValue, value)
    return value
  }
}

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
}

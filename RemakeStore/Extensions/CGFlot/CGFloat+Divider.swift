//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

extension CGFloat {
  func divider(padding: CGFloat, lineSpacing: CGFloat, divider: Int) -> CGFloat {
    let height = self - CGFloat(divider - 1)
    let inner = padding - CGFloat(divider - 1)
    let convertedHight = height * inner * lineSpacing

    return convertedHight / CGFloat(divider)
  }
}

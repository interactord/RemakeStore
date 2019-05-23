//
// Created by Scott Moon on 2019-05-23.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

extension UIScrollView {

  func clankingScrollEffect(to offsetY: CGFloat) {
    if self.contentOffset.y < offsetY {
      self.isScrollEnabled = false
      self.isScrollEnabled = true
    }
  }
}

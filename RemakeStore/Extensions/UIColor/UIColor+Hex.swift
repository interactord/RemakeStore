//
//  String+Color.swift
//  RemakeStore
//
//  Created by Scott Moon on 17/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

private extension Int {
  func duplicate4bits() -> Int {
    return (self << 4) + self
  }
}

extension UIColor {
  convenience init?(hex3: Int, alpha: Float) {
    self.init(
      red: CGFloat(((hex3 & 0xf00) >> 8).duplicate4bits()) / 255.0,
      green: CGFloat(((hex3 & 0x0F0) >> 8).duplicate4bits()) / 255.0,
      blue: CGFloat(((hex3 & 0x00F) >> 8).duplicate4bits()) / 255.0,
      alpha: CGFloat(alpha)
    )
  }

  convenience init?(hex6: Int, alpha: Float) {
    self.init(
      red: CGFloat((hex6 & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((hex6 & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat((hex6 & 0x0000FF) >> 0) / 255.0,
      alpha: CGFloat(alpha)
    )
  }
}

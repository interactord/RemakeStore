//
//  UIStackview+Extension.swift
//  RemakeStore
//
//  Created by Scott Moon on 24/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

extension UIStackView {
  @discardableResult
  func removeAllArrangedSubviews() -> [UIView] {
    let removedSubviews = arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
      self.removeArrangedSubview(subview)
      NSLayoutConstraint.deactivate(subview.constraints)
      subview.removeFromSuperview()
      return removedSubviews + [subview]
    }
    return removedSubviews
  }
}

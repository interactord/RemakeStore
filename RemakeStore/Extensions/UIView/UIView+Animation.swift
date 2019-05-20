//
// Created by Scott Moon on 2019-05-17.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

extension UIView {
  func defaultAnimated(
    duration: TimeInterval = 0.7,
    delay: TimeInterval = 0.0,
    usingSpringWithDamping: CGFloat = 0.7,
    initialSpringVelocity: CGFloat = 0.7,
    options: AnimationOptions = .curveEaseOut,
    animations: @escaping () -> Void,
    completion: @escaping (Bool) -> Void
  ) {
    UIView.animate(
      withDuration: duration,
      delay: delay,
      usingSpringWithDamping: usingSpringWithDamping,
      initialSpringVelocity: initialSpringVelocity,
      options: options,
      animations: animations,
      completion: completion
    )
  }

  func defaultAnimated(
    duration: TimeInterval = 0.7,
    delay: TimeInterval = 0.0,
    usingSpringWithDamping: CGFloat = 0.7,
    initialSpringVelocity: CGFloat = 0.7,
    options: AnimationOptions = .curveEaseOut,
    animations: @escaping () -> Void
  ) {
    UIView.animate(
      withDuration: duration,
      delay: delay,
      usingSpringWithDamping: usingSpringWithDamping,
      initialSpringVelocity: initialSpringVelocity,
      options: options,
      animations: animations
    )
  }

  func animated(transform: CGAffineTransform) {
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 1,
      initialSpringVelocity: 1,
      options: .curveEaseOut,
      animations: {
        self.transform = transform
      }
    )
  }
}

//
//  Abbrevation.swift
//  RemakeStore
//
//  Created by Scott Moon on 02/06/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation

struct Abbrevation {
  let threshold: Double, divisor: Double, suffix: String

  init(threshold: Double = 0, divisor: Double = 0, suffix: String = "") {
    self.threshold = threshold
    self.divisor = divisor
    self.suffix = suffix
  }
}

extension Abbrevation {

  func makeUnits() -> [Abbrevation] {
    return [
      Abbrevation(threshold: 0, divisor: 1, suffix: ""),
      Abbrevation(threshold: 1_000.0, divisor: 1_000.0, suffix: "K"),
      Abbrevation(threshold: 100_000.0, divisor: 1_000_000.0, suffix: "M"),
      Abbrevation(threshold: 100_000_000.0, divisor: 1_000_000_000.0, suffix: "B")
    ]
  }
}

extension Abbrevation: Equatable {
  static func == (lhs: Abbrevation, rhs: Abbrevation) -> Bool {
    return lhs.threshold == rhs.threshold
      && lhs.divisor == lhs.divisor
      && lhs.suffix == lhs.suffix
  }
}

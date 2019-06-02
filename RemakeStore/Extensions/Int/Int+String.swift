//
//  String+NumberUnit.swift
//  RemakeStore
//
//  Created by Scott Moon on 02/06/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation

extension Int {

  func formatUsingAbbrevation () -> String {
    let abbreviation = selectedAbbrevation()

    let value = Double(self) / abbreviation.divisor
    let numberFormatter = NumberFormatter()

    numberFormatter.positiveSuffix = abbreviation.suffix
    numberFormatter.negativeSuffix = abbreviation.suffix
    numberFormatter.allowsFloats = true
    numberFormatter.minimumIntegerDigits = 1
    numberFormatter.minimumFractionDigits = 0
    numberFormatter.maximumFractionDigits = 1

    return numberFormatter.string(from: .init(value: value)) ?? ""
  }

  func selectedAbbrevation() -> Abbrevation {

    let startValue = Double(abs(self))

    let abbreviations = Abbrevation().makeUnits()

    var prevAbbreviation = abbreviations[0]
    for tmpAbbreviation in abbreviations {
      if startValue < tmpAbbreviation.threshold {
        break
      }
      prevAbbreviation = tmpAbbreviation
    }
    return prevAbbreviation
  }
}

//
//  IntStringSpec.swift
//  RemakeStore
//
//  Created by Scott Moon on 02/06/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import XCTest

@testable import RemakeStore

class IntStringSpec: XCTestCase {
  var sut: Int?

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_oneOfThree_digits_abbrevation() {
    let units = Abbrevation().makeUnits()
    let expectedAbbr = units[0]

    sut = 0
    let oneDigitAbbr = sut?.selectedAbbrevation()
    let oneAbbr = sut?.formatUsingAbbrevation()
    XCTAssertEqual(expectedAbbr, oneDigitAbbr)
    XCTAssertEqual("0", oneAbbr)

    sut = 30
    let twoDigitsAbbr = sut?.selectedAbbrevation()
    let twoAbbr = sut?.formatUsingAbbrevation()
    XCTAssertEqual(expectedAbbr, twoDigitsAbbr)
    XCTAssertEqual("30", twoAbbr)

    sut = 722
    let threeDigitsAbbr = sut?.selectedAbbrevation()
    let threeAbbr = sut?.formatUsingAbbrevation()
    XCTAssertEqual(expectedAbbr, threeDigitsAbbr)
    XCTAssertEqual("722", threeAbbr)
  }

  func test_fourOfFive_digits_abbrevation() {
    let units = Abbrevation().makeUnits()
    let expectedAbbr = units[1]

    sut = 1_972
    let fourDigitsAbbr = sut?.selectedAbbrevation()
    let fourAbbr = sut?.formatUsingAbbrevation()
    XCTAssertEqual(expectedAbbr, fourDigitsAbbr)
    XCTAssertEqual("2K", fourAbbr)

    sut = 37_209
    let fiveDigitsAbbr = sut?.selectedAbbrevation()
    let fiveAbbr = sut?.formatUsingAbbrevation()
    XCTAssertEqual(expectedAbbr, fiveDigitsAbbr)
    XCTAssertEqual("37.2K", fiveAbbr)
  }

  func test_sixOfEight_digits_abbrevation() {
    let units = Abbrevation().makeUnits()
    let expectedAbbr = units[2]

    sut = 872_159
    let sixDigitsAbbr = sut?.selectedAbbrevation()
    let sixAbbr = sut?.formatUsingAbbrevation()
    XCTAssertEqual(expectedAbbr, sixDigitsAbbr)
    XCTAssertEqual("0.9M", sixAbbr)

    sut = 9_751_012
    let sevenDigitsAbbr = sut?.selectedAbbrevation()
    let sevenAbbr = sut?.formatUsingAbbrevation()
    XCTAssertEqual(expectedAbbr, sevenDigitsAbbr)
    XCTAssertEqual("9.8M", sevenAbbr)

    sut = 98_123_978
    let eightDigitsAbbr = sut?.selectedAbbrevation()
    let eightAbbr = sut?.formatUsingAbbrevation()
    XCTAssertEqual(expectedAbbr, eightDigitsAbbr)
    XCTAssertEqual("98.1M", eightAbbr)
  }

  func test_nineOfTwelve_digits_abbrevation() {
     let units = Abbrevation().makeUnits()
    let expectedAbbr = units[3]

    sut = 587_456_123
    let nineDigitsAbbr = sut?.selectedAbbrevation()
    let nineAbbr = sut?.formatUsingAbbrevation()
    XCTAssertEqual(expectedAbbr, nineDigitsAbbr)
    XCTAssertEqual("0.6B", nineAbbr)

    sut = 6_972_487_978
    let tenDigitsAbbr = sut?.selectedAbbrevation()
    let tenAbbr = sut?.formatUsingAbbrevation()
    XCTAssertEqual(expectedAbbr, tenDigitsAbbr)
    XCTAssertEqual("7B", tenAbbr)

    sut = 98_475_685_123
    let elevenDigitsAbbr = sut?.selectedAbbrevation()
    let elevenAbbr = sut?.formatUsingAbbrevation()
    XCTAssertEqual(expectedAbbr, elevenDigitsAbbr)
    XCTAssertEqual("98.5B", elevenAbbr)
  }

}

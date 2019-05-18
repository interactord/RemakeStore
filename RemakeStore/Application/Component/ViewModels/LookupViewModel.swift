//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol LookupViewModelOutput {
  var name: Observable<String> { get }
  var releaseNote: Observable<String> { get }
  var appIconImageUrlPath: Observable<String> { get }
  var priceFormat: Observable<String> { get }
  var category: Observable<String> { get }
  var rating: Observable<String> { get }
  var screenshotUrlPaths: Observable<[String]> { get }

  var result: LookupInformation { get }
}

protocol LookupViewModeling {
  var outputs: LookupViewModelOutput { get }
}

protocol LookupViewModelBindable {
  func bind(to viewModel: LookupViewModeling)
}

typealias LookupViewModelType =
  LookupViewModelOutput & LookupViewModeling

class LookupViewModel: LookupViewModelType {

  // MARK: - Inputs & Outputs

  var outputs: LookupViewModelOutput {
    return self
  }

  // MARK: - Inputs

  var screenshotImageView: BehaviorSubject<[UIImageView]?> = .init(value: nil)

  // MARK: - Outputs

  var name: Observable<String>
  var releaseNote: Observable<String>
  var appIconImageUrlPath: Observable<String>
  var priceFormat: Observable<String>
  var category: Observable<String>
  var rating: Observable<String>
  var result: LookupInformation
  var screenshotUrlPaths: Observable<[String]>

  init(withResult result: LookupInformation) {
    self.result = result

    let informationAction = Observable.just(result).observeOn(MainScheduler.asyncInstance)
    name = informationAction.map { $0.trackName }
    releaseNote = informationAction.map { $0.releaseNotes ?? "" }
    appIconImageUrlPath = informationAction.map { $0.artworkUrl100 }
    category = informationAction.map { $0.primaryGenreName }
    rating = informationAction.map { "\($0.averageUserRating ?? 0)" }
    priceFormat = informationAction.map { $0.formattedPrice ?? "" }
    screenshotUrlPaths = informationAction.map { $0.screenshotUrls }.ignoreNil()
  }
}

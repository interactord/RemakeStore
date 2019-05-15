//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol FeedResultViewModelOutput {
  var name: Observable<String> { get }
  var companyName: Observable<String> { get }
  var iconImageUrlPath: Observable<String> { get }
}

protocol FeedResultViewModeling {
  var outputs: FeedResultViewModelOutput { get }
}

protocol FeedResultViewModelBindable {
  func bind(to viewModel: FeedResultViewModeling)
}

typealias FeedResultViewModelType =
  FeedResultViewModelOutput & FeedResultViewModeling

class FeedResultViewModel: FeedResultViewModelType {

  // MARK: - Inputs & Outputs

  var outputs: FeedResultViewModelOutput {
    return self
  }

  // MARK: - Outputs

  var name: Observable<String>
  var companyName: Observable<String>
  var iconImageUrlPath: Observable<String>

  init(withFeedResult feedResult: FeedResult) {
    let feedResultAction = Observable.just(feedResult).observeOn(MainScheduler.asyncInstance)

    name = feedResultAction.map { $0.name }
    companyName = feedResultAction.map { $0.artistName }
    iconImageUrlPath = feedResultAction.map { $0.artworkUrl100 }
  }
}

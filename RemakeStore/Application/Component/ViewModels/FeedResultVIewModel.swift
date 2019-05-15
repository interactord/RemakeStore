//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol FeedResultViewModelOutput {
  var feedResult: Observable<FeedResult> { get }
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

  var feedResult: Observable<FeedResult>

  init(withFeedResult feedResult: FeedResult) {
    self.feedResult = Observable.just(feedResult).observeOn(MainScheduler.asyncInstance)
  }
}

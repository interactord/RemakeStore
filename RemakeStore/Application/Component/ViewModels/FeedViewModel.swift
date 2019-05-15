//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol FeedViewModelOutput {
  var title: Observable<String> { get }
  var feedResultViewModel: Observable<[FeedResultViewModel]> { get }
}

protocol FeedViewModelModeling {
  var outputs: FeedViewModelOutput { get }
}

protocol FeedViewModelBindable {
  func bind(to viewModel: FeedViewModelModeling)
}

typealias FeedViewModelType =
  FeedViewModelOutput & FeedViewModelModeling

class FeedViewModel: FeedViewModelType {

  // MARK: - Inputs & Outputs

  var outputs: FeedViewModelOutput {
    return self
  }

  // MARK: - Outputs

  var title: Observable<String>
  var feedResultViewModel: Observable<[FeedResultViewModel]>

  init(withFeed feed: Feed) {
    self.title = Observable.just(feed.title).observeOn(MainScheduler.asyncInstance)

    self.feedResultViewModel = Observable.just(feed.results).map {
      $0.map { FeedResultViewModel(withFeedResult: $0) }
    }
  }
}

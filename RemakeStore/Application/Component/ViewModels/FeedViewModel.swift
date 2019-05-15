//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol FeedViewModelOutput {
  var feed: Observable<Feed> { get }
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

  var feed: Observable<Feed>

  init(withFeed feed: Feed) {
    self.feed = Observable.just(feed).observeOn(MainScheduler.asyncInstance)
  }
}

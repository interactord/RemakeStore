//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol FeedResultViewModelInput {
  var fetchAppIconImage: BehaviorSubject<UIImage?> { get }
}

protocol FeedResultViewModelOutput {
  var id: Observable<String> { get }
  var name: Observable<String> { get }
  var companyName: Observable<String> { get }
  var iconImageUrlPath: Observable<String> { get }
  var iconImage: Observable<UIImage> { get }
}

protocol FeedResultViewModeling {
  var inputs: FeedResultViewModelInput { get }
  var outputs: FeedResultViewModelOutput { get }
}

protocol FeedResultViewModelBindable {
  func bind(to viewModel: FeedResultViewModeling)
}

typealias FeedResultViewModelType =
  FeedResultViewModelInput & FeedResultViewModelOutput & FeedResultViewModeling

class FeedResultViewModel: FeedResultViewModelType {

  // MARK: - Inputs & Outputs

  var inputs: FeedResultViewModelInput {
    return self
  }

  var outputs: FeedResultViewModelOutput {
    return self
  }

  // MARK: - Inputs

  var fetchAppIconImage: BehaviorSubject<UIImage?> = .init(value: nil)

  // MARK: - Outputs

  var name: Observable<String>
  var companyName: Observable<String>
  var iconImageUrlPath: Observable<String>
  var id: Observable<String>
  private(set) lazy var iconImage: Observable<UIImage> = {
    let fetchAppIconImage = self.fetchAppIconImage
    return fetchAppIconImage.asObservable().ignoreNil()
  }()

  init(withFeedResult feedResult: FeedResult) {
    let feedResultAction = Observable.just(feedResult).observeOn(MainScheduler.asyncInstance)

    name = feedResultAction.map { $0.name }
    companyName = feedResultAction.map { $0.artistName }
    iconImageUrlPath = feedResultAction.map { $0.artworkUrl100 }
    id = feedResultAction.map { $0.id }
  }
}

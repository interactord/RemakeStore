//
// Created by Scott Moon on 2019-05-18.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol TodayItemViewModelInput {
  var fetchImage: BehaviorSubject<UIImage?> { get }
}

protocol TodayItemViewModelOutput {
  var cellType: TodayListViewCellType { get }
  var title: Observable<String> { get }
  var category: Observable<String> { get }
  var description: Observable<String> { get }
  var backgroundImageURL: Observable<String> { get }
  var backgroundImage: Observable<UIImage> { get }
  var feedResultViewModels: Observable<[FeedResultViewModeling]> { get }
}

protocol TodayItemViewModeling {
  var inputs: TodayItemViewModelInput { get }
  var outputs: TodayItemViewModelOutput { get }
}

protocol TodayItemViewModelBindable {
  func bind(to viewModel: TodayItemViewModeling)
}

typealias TodayItemViewModelType =
  TodayItemViewModelInput & TodayItemViewModelOutput & TodayItemViewModeling

class TodayItemViewModel: TodayItemViewModelType {

  // MARK: - Inputs & Outputs

  var inputs: TodayItemViewModelInput {
    return self
  }

  var outputs: TodayItemViewModelOutput {
    return self
  }

  // MARK: - Inputs

  var fetchImage: BehaviorSubject<UIImage?> = .init(value: nil)

  // MARK: - Outputs

  private(set) lazy var title: Observable<String> = {
    let todayItem = self.todayItem
    return Observable.just(todayItem)
      .map { $0.title }
      .observeOn(MainScheduler.instance)
  }()

  private(set) lazy var category: Observable<String> = {
    let todayItem = self.todayItem
    return Observable.just(todayItem)
      .map { $0.category }
      .observeOn(MainScheduler.instance)
  }()

  private(set) lazy var description: Observable<String> = {
    let todayItem = self.todayItem
    return Observable.just(todayItem)
      .map { $0.description }
      .ignoreNil()
      .observeOn(MainScheduler.instance)
  }()

  private(set) lazy var backgroundImageURL: Observable<String> = {
    let todayItem = self.todayItem
    return Observable.just(todayItem)
      .map { $0.imageUrl }
      .ignoreNil()
      .observeOn(MainScheduler.instance)
  }()

  private(set) lazy var backgroundImage: Observable<UIImage> = {
    let fetchImage = self.fetchImage
    return fetchImage.asObservable().ignoreNil()
  }()

  private(set) lazy var feedResultViewModels: Observable<[FeedResultViewModeling]> = {
    let todayItem = self.todayItem
    return Observable.just(todayItem)
      .map { $0.rss?.feed.results }
      .ignoreNil()
      .map {
        $0.map { FeedResultViewModel(withFeedResult: $0) }
      }
      .observeOn(MainScheduler.asyncInstance)
  }()

  private(set) lazy var cellType: TodayListViewCellType = {
    let todayItem = self.todayItem
    switch todayItem.cellType {
    case "TodayFullBackgroundCell":
      return .todayFullBackgroundCell
    case "TodayMultipleAppCell":
      return .todayMultipleAppCell
    default:
      return .todayFullBackgroundCell
    }
  }()

  // MARK: - Private

  private let todayItem: TodayItem
  private lazy var todayItemAction: Observable<TodayItem> = {
    let todayItem = self.todayItem
    return Observable.just(todayItem)
  }()

  init(withTodayItem todayItem: TodayItem) {
    self.todayItem = todayItem
  }
}

//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol ReviewsEntryViewModelOutput {
  var author: Observable<String> { get }
  var title: Observable<String> { get }
  var rating: Observable<Int> { get }
  var body: Observable<String> { get }
}

protocol ReviewsEntryViewModeling {
  var outputs: ReviewsEntryViewModelOutput { get }
}

protocol ReviewsEntryViewModelBindable {
  func bind(to viewModel: ReviewsEntryViewModeling)
}

typealias ReviewsEntryViewModelType =
  ReviewsEntryViewModelOutput & ReviewsEntryViewModeling

class ReviewsEntryViewModel: ReviewsEntryViewModelType {

  // MARK: - Inputs & Outputs

  var outputs: ReviewsEntryViewModelOutput {
    return self
  }

  var author: Observable<String>
  var title: Observable<String>
  var rating: Observable<Int>
  var body: Observable<String>

  init(withEntry entry: Entry) {

    let entryAction = Observable.just(entry)
    author = entryAction.map { $0.author.name.label }
    title = entryAction.map { $0.title.label }
    body = entryAction.map { $0.content.label }
    rating = entryAction.map { $0.rating.label.toInt() ?? 0 }
  }
}

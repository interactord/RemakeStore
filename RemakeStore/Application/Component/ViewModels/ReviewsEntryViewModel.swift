//
// Created by Scott Moon on 2019-05-11.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol ReviewsEntryViewModelInput {
}

protocol ReviewsEntryViewModelOutput {
	var author: Observable<String> { get }
	var title: Observable<String> { get }
	var rating: Observable<Int> { get }
	var body: Observable<String> { get }
}

protocol ReviewsEntryViewModeling {
	var inputs: ReviewsEntryViewModelInput { get }
	var outputs: ReviewsEntryViewModelOutput { get }
}

protocol ReviewsEntryViewModelBindable {
	func bind(to viewModel: ReviewsEntryViewModeling)
}

typealias ReviewsEntryViewModelType =
	ReviewsEntryViewModelInput & ReviewsEntryViewModelOutput & ReviewsEntryViewModeling

class ReviewsEntryViewModel: ReviewsEntryViewModelType {

	// MARK: - Inputs & Outputs

	var inputs: ReviewsEntryViewModelInput {
		return self
	}
	
	var outputs: ReviewsEntryViewModelOutput {
		return self
	}

	var author: Observable<String>
	var title: Observable<String>
	var rating: Observable<Int>
	var body: Observable<String>

	init(withEntry entry: Entry) {
		let scheduler = MainScheduler.asyncInstance
		self.author = Observable.just(entry.author.name.label).observeOn(scheduler)
		self.title = Observable.just(entry.title.label).observeOn(scheduler)
		self.body = Observable.just(entry.content.label).observeOn(scheduler)
		self.rating = Observable.just(entry.rating.label.toInt() ?? 0).observeOn(scheduler)
	}

}

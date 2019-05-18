//
// Created by Scott Moon on 2019-05-18.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol TodayItemViewModelOutput {
}

protocol TodayItemViewModeling {
	var outputs: TodayItemViewModelOutput { get }
}

protocol TodayItemViewModelBindable {
	func bind(to viewModel: TodayViewModeling)
}

typealias TodayItemViewModelType =
	TodayItemViewModelOutput & TodayItemViewModeling

class TodayItemViewModel: TodayItemViewModelType {

	// MARK: - Inputs & Outputs

	var outputs: TodayItemViewModelOutput {
		return self
	}

	init(withTodayItem todayItem: TodayItem) {
		print(todayItem)
	}
}

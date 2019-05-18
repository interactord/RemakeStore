//
// Created by Scott Moon on 2019-05-18.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

import RxSwift

protocol TodayItemViewModelOutput {
	var cellType: TodayListViewCellType { get }
}

protocol TodayItemViewModeling {
	var outputs: TodayItemViewModelOutput { get }
}

protocol TodayItemViewModelBindable {
	func bind(to viewModel: TodayItemViewModeling)
}

typealias TodayItemViewModelType =
	TodayItemViewModelOutput & TodayItemViewModeling

class TodayItemViewModel: TodayItemViewModelType {

	// MARK: - Inputs & Outputs

	var outputs: TodayItemViewModelOutput {
		return self
	}

	// MARK: - Outputs

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

	init(withTodayItem todayItem: TodayItem) {
		self.todayItem = todayItem
	}
}

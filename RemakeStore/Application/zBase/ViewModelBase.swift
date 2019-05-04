//
// Created by Scott Moon on 2019-05-04.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

protocol ViewModelBased: class {
	associatedtype ViewModelType
	var viewModel: ViewModelType! { get set }

	func bindViewModel()
}

extension ViewModelBased where Self: UIViewController {
	func bind(to viewModel: Self.ViewModelType) {
		self.viewModel = viewModel
		loadViewIfNeeded()
		bindViewModel()
	}
}

extension ViewModelBased where Self: UICollectionViewCell {
	func bind(to viewModel: Self.ViewModelType) {
		self.viewModel = viewModel
		bindViewModel()
	}
}

extension ViewModelBased where Self: UITableViewCell {
	func bind(to viewModel: Self.ViewModelType) {
		self.viewModel = viewModel
		bindViewModel()
	}
}

extension ViewModelBased where Self: UICollectionReusableView {
  func bind(to viewModel: Self.ViewModelType) {
    self.viewModel = viewModel
    bindViewModel()
  }
}

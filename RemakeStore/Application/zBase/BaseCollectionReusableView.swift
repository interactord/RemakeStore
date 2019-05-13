//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift

class BaseCollectionReusableView: UICollectionReusableView {

	var disposeBag = DisposeBag()

	convenience init() {
		self.init(frame: .zero)
		setupSubView()
		setupConstant()
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		disposeBag = DisposeBag()
		reset()
	}

	func setupConstant() {
	}

	func setupSubView() {
	}

	func reset() {
	}
}

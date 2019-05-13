//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCUIBuildKit
import SCLayoutKit
import RxSwift

class ReviewRowCell: BaseCollectionViewCell {

	// MARK: - Views
	private lazy var reviewRatingLabel: UILabel = {
		return LabelBuilder()
			.setText("Reviews & Ratings")
			.setFont(DefaultTheme.Font.title3)
			.build()
	}()

	private lazy var reviewListView: ReviewListView = {
		return ReviewListView(withLayoutStyle: .horizontalSnapping)
	}()

	override func setupSubView() {
		super.setupSubView()

		backgroundColor = .white
		addSubview(reviewRatingLabel)
		addSubview(reviewListView)
	}

	override func setupConstant() {
		super.setupConstant()

		reviewRatingLabel
			.setTopAnchor(topAnchor, padding: 20)
			.setLeadingAnchor(leadingAnchor, padding: 20)
			.setTrailingAnchor(trailingAnchor, padding: 20)

		reviewListView
			.setTopAnchor(reviewRatingLabel.bottomAnchor, padding: 20)
			.setLeadingAnchor(leadingAnchor)
			.setTrailingAnchor(trailingAnchor)
			.setBottomAnchor(bottomAnchor)
	}

	func bind(to viewModels: [ReviewsEntryViewModeling]) {
		Observable.just(viewModels)
			.bind(to: reviewListView.rx.updateViewModels)
			.disposed(by: disposeBag)
	}

}

extension ReviewRowCell: CellContentClassIdentifiable {
}

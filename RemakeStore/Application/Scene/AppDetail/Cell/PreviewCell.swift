//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import SCLayoutKit
import SCUIBuildKit

class PreviewCell: BaseCollectionViewCell {

	// MARK: - Views

	lazy var previewLabel: UILabel = {
		return LabelBuilder()
			.setText("Preview")
			.setFont(DefaultTheme.Font.title3)
			.build()
	}()

	lazy var previewScreensView = PreviewScreenshotsView()

	override func setupSubView() {
		super.setupSubView()
		addSubview(previewLabel)
		addSubview(previewScreensView)
	}

	override func setupConstant() {
		super.setupConstant()

		previewLabel
			.setTopAnchor(topAnchor)
			.setLeadingAnchor(leadingAnchor, padding: 20)
			.setTrailingAnchor(trailingAnchor, padding: 20)

		previewScreensView
			.setTopAnchor(previewLabel.bottomAnchor, padding: 20)
			.setLeadingAnchor(leadingAnchor)
			.setBottomAnchor(bottomAnchor)
			.setTrailingAnchor(trailingAnchor)
	}
}

extension PreviewCell: CellContentClassIdentifiable {
}

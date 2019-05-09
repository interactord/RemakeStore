//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

class AppDetailResultView: BaseCollectionView {

	// MARK: - Private

	private enum CollectionViewCellType: Int {
		case appDetailCell = 0, previewCell, reviewRowCell
	}

	private let cellItems = [
		CollectionViewCellType.appDetailCell,
		CollectionViewCellType.previewCell,
		CollectionViewCellType.reviewRowCell
	]

	override func setupDelegate() {
		super.setupDelegate()
		self.dataSource = self
		self.delegate = self
	}

	override func registerCell() {
		super.registerCell()
		self.register(cellType: AppDetailCell.self)
		self.register(cellType: PreviewCell.self)
		self.register(cellType: ReviewRowCell.self)
	}
}

// MARK: - UICollectionViewDataSource

extension AppDetailResultView: UICollectionViewDataSource {
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cellItems.count
	}

	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cellType = cellItems[indexPath.item]

		switch cellType {
		case .appDetailCell:
			let cell: AppDetailCell = collectionView.dequeueReusableCell(indexPath: indexPath)
			return cell
		case .previewCell:
			let cell: PreviewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
			cell.backgroundColor = .green
			return cell
		case .reviewRowCell:
			let cell: ReviewRowCell = collectionView.dequeueReusableCell(indexPath: indexPath)
			cell.backgroundColor = .blue
			return cell
		}
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AppDetailResultView: UICollectionViewDelegateFlowLayout {
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = frame.width
		var height: CGFloat = 280
		let cellType = cellItems[indexPath.item]

		switch cellType {
		case .appDetailCell:
			height = 280
		case .previewCell:
			height = 500
		case .reviewRowCell:
			height = 280
		}

		return .init(width: width, height: height)
	}

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 0, left: 0, bottom: 10, right: 0)
	}
}

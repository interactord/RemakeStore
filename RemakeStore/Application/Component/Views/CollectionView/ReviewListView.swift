//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

class ReviewListView: BaseCollectionView {
	// MARK: - Private

	private let cellSpacing: CGFloat = 40
	private let minimumSectionHeightSpacing: CGFloat = 16

	private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

	override func setupDelegate() {
		super.setupDelegate()
		self.dataSource = self
		self.delegate = self
	}

	override func registerCell() {
		super.registerCell()
		self.register(cellType: ReviewCell.self)
	}

	override func setupView() {
		super.setupView()
		backgroundColor = .white
		contentInset = padding
	}
}

// MARK: - UICollectionViewDataSource

extension ReviewListView: UICollectionViewDataSource {

	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}

	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: ReviewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ReviewListView: UICollectionViewDelegateFlowLayout {

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = frame.width - cellSpacing
		return .init(width: width, height: frame.height)
	}

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return minimumSectionHeightSpacing
	}
}

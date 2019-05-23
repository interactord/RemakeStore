//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ReviewListView: BaseCollectionView {

	// MARK: Public
	var reviewEntryViewModels: [ReviewsEntryViewModeling]?

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
		return reviewEntryViewModels?.count ?? 0
	}

	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: ReviewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
		if let viewModel = reviewEntryViewModels?[indexPath.item] {
			cell.bind(to: viewModel)
		}
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

// MARK: - RX Binder

extension Reactive where Base: ReviewListView {
	internal var updateViewModels: Binder<[ReviewsEntryViewModeling]> {
		return Binder(self.base) { base, result in
			base.reviewEntryViewModels = result
			base.reloadData()
		}
	}
}

//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class PreviewScreenshotsView: BaseCollectionView {

	// MARK: - Public

	var screenshotViewModels: [ScreenshotViewModeling]?

	// MARK: - Private

	private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

	override func setupDelegate() {
		super.setupDelegate()
		self.dataSource = self
		self.delegate = self
	}

	override func registerCell() {
		super.registerCell()
		self.register(cellType: ScreenshotCell.self)
	}

	override func setupView() {
		super.setupView()
		contentInset = padding
		backgroundColor = .white
	}
}

// MARK: - UICollectionViewDataSource

extension PreviewScreenshotsView: UICollectionViewDataSource {

	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return screenshotViewModels?.count ?? 0
	}

	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: ScreenshotCell = collectionView.dequeueReusableCell(indexPath: indexPath)
    if let viewModel = screenshotViewModels?[indexPath.item] {
      cell.bind(to: viewModel)
    }
		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PreviewScreenshotsView: UICollectionViewDelegateFlowLayout {
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return .init(width: 250, height: frame.height)
	}
}

// MARK: - RX Binder

extension Reactive where Base: PreviewScreenshotsView {
  internal var updateViewModels: Binder<[ScreenshotViewModeling]> {
    return Binder(self.base) { base, result in
      base.screenshotViewModels = result
      base.reloadData()
    }
  }
}

//
// Created by Scott Moon on 2019-05-14.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AppsHorizontalListView: BaseCollectionView {

  // MARK: Public

  var feedResultViewModels: [FeedResultViewModel]?

  // MARK: - Private

  private let topBottomPadding: CGFloat = 12
  private let lineSpacing: CGFloat = 10
  private let cellVerticalSpacing: CGFloat = 48

  override func setupView() {
    super.setupView()
    backgroundColor = .white
    contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
  }

  override func setupDelegate() {
    super.setupDelegate()
    self.dataSource = self
    self.delegate = self
  }

  override func registerCell() {
    super.registerCell()

    register(cellType: AppRowCell.self)
  }
}

// MARK: - UICollectionViewDataSource

extension AppsHorizontalListView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return feedResultViewModels?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: AppRowCell = collectionView.dequeueReusableCell(indexPath: indexPath)
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AppsHorizontalListView: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = frame.height.dividerHeight(padding: topBottomPadding, lineSpacing: lineSpacing, grid: 3)
    return .init(width: frame.width - cellVerticalSpacing, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return lineSpacing
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
  }
}

// MARK: - Reactive Binder

extension Reactive where Base: AppsHorizontalListView {

  internal var updateFeedResults: Binder<[FeedResultViewModel]> {
    return Binder(self.base) { base, result in
      base.feedResultViewModels = result
      base.reloadData()
    }
  }
}

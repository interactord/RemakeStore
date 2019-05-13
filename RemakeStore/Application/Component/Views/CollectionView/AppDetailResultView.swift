//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AppDetailResultView: BaseCollectionView {

  // MARK: - Private

  var lookupViewModel: LookupViewModeling?
  var screenshotViewModels: [ScreenshotViewModeling]?
  var reviewEntryViewModels: [ReviewsEntryViewModeling]?

  private enum CollectionViewCellType: Int {
    case lookupCell = 0, previewCell, reviewRowCell
  }

  private let cellItems = [
    CollectionViewCellType.lookupCell,
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
    self.register(cellType: LookupCell.self)
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
    case .lookupCell:
      let cell: LookupCell = collectionView.dequeueReusableCell(indexPath: indexPath)
      if let viewModel = lookupViewModel {
        cell.bind(to: viewModel)
      }
      return cell
    case .previewCell:
      let cell: PreviewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
      if let viewModel = screenshotViewModels {
        cell.bind(to: viewModel)
      }
      return cell
    case .reviewRowCell:
      let cell: ReviewRowCell = collectionView.dequeueReusableCell(indexPath: indexPath)
      if let viewModel = reviewEntryViewModels {
        cell.bind(to: viewModel)
      }
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
    case .lookupCell:
      let cell = LookupCell(frame: .init(x: 0, y: 0, width: width, height: 1_000))
      if let viewModel = lookupViewModel {
        cell.sizeViewModel = viewModel
        cell.layoutIfNeeded()
      }
      let estimatedSize = cell.systemLayoutSizeFitting(.init(width: width, height: 1_000))
      height = estimatedSize.height

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

// MARK: - RX Binder

extension Reactive where Base: AppDetailResultView {

  internal var updateLookupViewModel: Binder<LookupViewModeling> {
    return Binder(self.base) { base, result in
      base.lookupViewModel = result
      base.reloadData()
    }
  }

  internal var updateScreenshotViewModels: Binder<[ScreenshotViewModeling]> {
    return Binder(self.base) { base, result in
      base.screenshotViewModels = result
      base.reloadData()
    }
  }

  internal var updateReviewsEntryViewModels: Binder<[ReviewsEntryViewModeling]> {
    return Binder(self.base) { base, result in
      base.reviewEntryViewModels = result
      base.reloadData()
    }
  }

}

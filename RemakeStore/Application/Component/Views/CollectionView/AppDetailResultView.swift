//
// Created by Scott Moon on 2019-05-10.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class AppDetailResultView: BaseCollectionView {

  // MARK: - Private

  var item: LookupViewModeling?

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
    print(cellItems.count)
    return cellItems.count
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cellType = cellItems[indexPath.item]

    switch cellType {
    case .lookupCell:
      let cell: LookupCell = collectionView.dequeueReusableCell(indexPath: indexPath)
      if let viewModel = item {
        cell.bind(to: viewModel)
      }
      return cell
    case .previewCell:
      let cell: PreviewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
      return cell
    case .reviewRowCell:
      let cell: ReviewRowCell = collectionView.dequeueReusableCell(indexPath: indexPath)
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

extension Reactive where Base: AppDetailResultView {
  internal var updateItems: Binder<LookupViewModeling> {
    return Binder(self.base) { base, result in
      base.item = result
      base.reloadData()
    }
  }
}

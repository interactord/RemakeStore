//
// Created by Scott Moon on 2019-05-16.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

enum TodayListViewCellType: Int {
  case todayFullBackgroundCell, todayMultipleAppCell
}

class TodayListView: BaseCollectionView {

  // MARK: Public

  var todayItemViewModels: [TodayItemViewModeling]?

  // MARK: - Private

  private let contentCellPadding: CGFloat = 48
  private let contentCellMargin: UIEdgeInsets = .init(top: 10, left: 0, bottom: 32, right: 0)
  private let cellLineSpacing: CGFloat = 32
  private let headerCellHeight: CGFloat = 85

  override func registerCell() {
    super.registerCell()
    register(cellType: TodayFullBackgroundCell.self)
    register(cellType: TodayMultipleAppCell.self)
    register(kind: UICollectionView.elementKindSectionHeader, cellType: TodayHeader.self)
  }

  override func setupDelegate() {
    super.setupDelegate()

    self.delegate = self
    self.dataSource = self
  }

  override func setupView() {
    super.setupView()
    backgroundColor = DefaultTheme.Color.secondaryColor
  }
}

// MARK: - UICollectionViewDataSource

extension TodayListView: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return todayItemViewModels?.count ?? 0
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let viewModel = todayItemViewModels?[indexPath.item] else {
      fatalError("Should be not nil")
    }

    switch viewModel.outputs.cellType {
    case .todayFullBackgroundCell:
      let cell: TodayFullBackgroundCell = collectionView.dequeueReusableCell(indexPath: indexPath)
      cell.bind(to: viewModel)
      return cell
    case .todayMultipleAppCell:
      let cell: TodayMultipleAppCell = collectionView.dequeueReusableCell(indexPath: indexPath)
      cell.bind(to: viewModel)
      return cell
    }
  }

  public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header: TodayHeader = collectionView.dequeueReusableCell(kind: kind, indexPath: indexPath)
    return header
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TodayListView: UICollectionViewDelegateFlowLayout {

  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: frame.width, height: headerCellHeight)
  }

  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let viewModel = todayItemViewModels?[indexPath.item] else {
      fatalError("Should be not nil")
    }
    return calculatedCellSize(cellType: viewModel.outputs.cellType)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return cellLineSpacing
  }

  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return contentCellMargin
  }

  private func calculatedCellSize(cellType: TodayListViewCellType) -> CGSize {
    let width = frame.width - contentCellPadding
    switch cellType {
    case .todayFullBackgroundCell:
      let cell = TodayFullBackgroundCell()
      return .init(width: width, height: cell.thumbnailHeight)
    case .todayMultipleAppCell:
      let cell = TodayMultipleAppCell()
      return .init(width: width, height: cell.thumbnailHeight)
    }
  }

}

// MARK: - RX Binder

extension Reactive where Base: TodayListView {
  internal var updateTodayItemViewModels: Binder<[TodayItemViewModeling]> {
    return Binder(self.base) { base, result in
      base.todayItemViewModels = result
      base.reloadData()
    }
  }
}

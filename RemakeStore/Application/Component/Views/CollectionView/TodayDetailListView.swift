//
// Created by Scott Moon on 2019-05-19.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class TodayDetailListView: BaseCollectionView {

  var headerViewModel: TodayItemViewModeling?

  override func setupView() {
    super.setupView()
    contentInsetAdjustmentBehavior = .never
    layer.masksToBounds = true
  }

  override func setupDelegate() {
    super.setupDelegate()
    self.dataSource = self
    self.delegate = self
  }

  override func registerCell() {
    super.registerCell()

    register(UICollectionViewCell.self, forCellWithReuseIdentifier: "fatalCell")
    register(cellType: TodayFullBackgroundCell.self)
    register(cellType: TodayMultipleAppCell.self)
  }
}

// MARK: - UICollectionViewDataSource

extension TodayDetailListView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let headerViewModel = headerViewModel else {
      return 0
    }
    switch headerViewModel.outputs.cellType {
    case .todayFullBackgroundCell:
      return 6
    case .todayMultipleAppCell:
      return 1
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let fatalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "fatalCell", for: indexPath)
    fatalCell.backgroundColor = .red
    guard let headerViewModel = headerViewModel else {
      return fatalCell
    }

    if indexPath.item == 0 {
      switch headerViewModel.outputs.cellType {
      case .todayFullBackgroundCell:
        let cell: TodayFullBackgroundCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.bind(to: headerViewModel)
        return cell
      case .todayMultipleAppCell:
        let cell: TodayMultipleAppCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.todayMultipleAppListView.changed(to: .fullScreen)
        cell.bind(to: headerViewModel)
        return cell
      }
    }

    return fatalCell
  }
}

// MARK: - FullScreenLayoutCollectionViewAnimatedable
extension TodayDetailListView: FullScreenLayoutCollectionViewAnimatedable {
  func startAnimation(cell: FullScreenLayoutCellAnimatedable) {
    UIView.defaultAnimated(animations: {
      cell.topConstraint.constant = cell.fullScreenPaddingTop
      self.layoutIfNeeded()
    })
  }

  func dismissAnimation(cell: FullScreenLayoutCellAnimatedable, startingFrame: CGRect) {
    UIView.defaultAnimated(animations: {
      cell.topConstraint.constant = cell.thumbnailPaddingTop
      cell
        .setWithAnchor(startingFrame.width)
        .setHeightAnchor(cell.thumbnailHeight)
      self.layoutIfNeeded()
    })
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TodayDetailListView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let headerViewModel = headerViewModel else {
      return .zero
    }

    if indexPath.item == 0 {
      return calculatedCellSize(cellType: headerViewModel.outputs.cellType)
    }

    return .init(width: frame.width, height: 438)
  }

  private func calculatedCellSize(cellType: TodayListViewCellType) -> CGSize {
    let width = frame.width
    switch cellType {
    case .todayFullBackgroundCell:
      let cell = TodayFullBackgroundCell()
      return .init(width: width, height: cell.fullScreenHeight)
    case .todayMultipleAppCell:
      let cell = TodayMultipleAppCell()
      return .init(width: width, height: cell.fullScreenHeight)
    }
  }
}

// MARK: - RX Binder

extension Reactive where Base: TodayDetailListView {
  internal var updateHeaderViewModel: Binder<TodayItemViewModeling> {
    return Binder(self.base) { base, result in
      base.headerViewModel = result
      base.reloadData()
    }
  }

  internal var clankingScrollEffect: Binder<Void> {
    return Binder(self.base) { base, _ in
      base.clankingScrollEffect(to: 0)
    }
  }
}

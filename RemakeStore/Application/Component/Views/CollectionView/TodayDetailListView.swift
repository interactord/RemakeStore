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
    return 6
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let fatalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "fatalCell", for: indexPath)

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
        cell.bind(to: headerViewModel)
        return cell
      }
    }

    return fatalCell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TodayDetailListView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: frame.width, height: 438)
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
}
